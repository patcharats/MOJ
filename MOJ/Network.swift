
//  Network.swift
//  test
//
//  Created by CBK-Admin on 4/19/2560 BE.
//
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration
class Network: NSObject {

    let API_BASE_URL = "http://mojapp.soft2serv.com/moj/api/1.0/"
    
    let API_LOGIN = "login"
    let API_REGISTER = "register"
    let API_FORGOT_PASSWORD = "forgot-password"
    let API_CHANGE_PASSWORD = "change-password"
    let API_ACCOUNT_PROFILE = "account-profile"
    let API_UPDATE_PROFILE = "update-profile"
    
    let API_DEPARTMENT = "departments/"
    let API_APPLICATION = "app"
    let API_DOCUMENT = "doc/"
    let API_FEED = "feeds/"
    let API_FEED_STATUS = "feeds/status/"
    let API_FEED_UPDATE = "feeds/update/"
    let API_COMPLAINTS = "complaints/"
    let API_COMPLAINT = "complaint/"
    let API_COMPLAINT_GUIDE = "compltguide"
    let API_COMPLAINT_POST = "compl"
    let API_COMPLAINT_POST_IMAGE = "uploadComplaintImage"
    let API_COMPLAINT_REPLY = "complaintreply/"
    let API_VERIFY_ID = "idcardverify"
    let API_CONTACTS = "contacts/"
    let API_CONTACTS_REPLY = "contacts/reply"
    let API_CONTACTS_NEW_POST = "contacts/newpost"
    let API_CONTACTS_NEW_USER = "contacts/newuser"
    let API_CONFIG = "config/all"
    let API_CONFIG_PROVINCE = "config/province"
    let API_CONFIG_AMPHUR = "config/amphur/"
    let API_CONFIG_DISTRICT = "config/district/"
    
    let API_VERIFY_ID_STATUS = "idcard-status"
    
    let API_SOCIAL_WORK_NEW_REQUEST = "socialwrk/newrequest/"
    let API_SOCIAL_WORK_REQUEST = "socialwrk/request/"
    let API_SOCIAL_WORK_SEARCH = "socialwrk/search"
    let API_SOCIAL_WORK_APPROVE_LIST = "socialwrk/approvallist/"
    let API_SOCIAL_WORK_APPROVE = "socialwrk/approve/"
    
    let KEY_RESPONSE_STATUS = "status"
    let KEY_RESPONSE_CODE = "code"
    let KEY_RESPONSE_MESSAGE = "message"
    
    let alertView = AlertView()
    let accountData = AccountData()
    let activityIndicator = ActivityIndicatorView()
    
    func post(name:String,param:Parameters,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        
        if isInternetAvailable(){
            let header: HTTPHeaders = [
                "token": accountData.getAccountToken()
            ]
            print("header :\(header)")
            
            print("******** api :\(self.API_BASE_URL+name)")
            activityIndicator.showActivityIndicator(uiView: viewController.view)
            print(param)
            Alamofire.request(API_BASE_URL+name, method: .post, parameters: param, encoding: JSONEncoding.default,headers: header)
                .responseJSON { response in
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        
                        print("******** request :\(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)!)")
                        print("******** response :\(JSON)")
                        
                        let status = JSON[self.KEY_RESPONSE_STATUS] as! NSDictionary
                        let code = status[self.KEY_RESPONSE_CODE] as! String
                        let message = status[self.KEY_RESPONSE_MESSAGE] as! String
                        self.activityIndicator.hideActivityIndicator(uiView: viewController.view)
                        completionHandler(JSON,code,message)
                        
                    }
            }
        }
        else{
            alertView.alert(title: alertView.ALERT_NO_INTERNET, message: "", buttonTitle: alertView.ALERT_OK, controller: viewController)
        }
        
    }
    
    func get(name:String,param:String,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        
        if isInternetAvailable(){
            print("******** api :\(self.API_BASE_URL+name+param)")
            activityIndicator.showActivityIndicator(uiView: viewController.view)
            Alamofire.request(API_BASE_URL+name+param, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        
                        print("******** response :\(JSON)")
                        let status = JSON[self.KEY_RESPONSE_STATUS] as! NSDictionary
                        let code = status[self.KEY_RESPONSE_CODE] as! String
                        let message = status[self.KEY_RESPONSE_MESSAGE] as! String
                        self.activityIndicator.hideActivityIndicator(uiView: viewController.view)
                        completionHandler(JSON,code,message)
                        
                    }
            }
        }
        else{
            alertView.alert(title: alertView.ALERT_NO_INTERNET, message: "", buttonTitle: alertView.ALERT_OK, controller: viewController)
        }
        
    }
    

    
    func postImage(name:String,param:NSDictionary,image:UIImage,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        

        let url = self.API_BASE_URL+name
    
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let imageData = UIImageJPEGRepresentation(image, 1) {
                    multipartFormData.append(imageData, withName: "images",fileName: "image.jpg", mimeType: "image/jpg")
                }
                
                for (key, value) in param {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
                }
                
                print(param)
                
                
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        
    }
    
    func getWithToken(name:String,param:String,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        if isInternetAvailable(){
            let header: HTTPHeaders = [
                "token": accountData.getAccountToken()
            ]
            
            print("header :\(header)")
            print("******** api :\(self.API_BASE_URL+name+param)")
            activityIndicator.showActivityIndicator(uiView: viewController.view)
            Alamofire.request(API_BASE_URL+name+param, method: .get, encoding: JSONEncoding.default,headers: header)
                .responseJSON { response in
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        
                        print("******** response :\(JSON)")
                        let status = JSON[self.KEY_RESPONSE_STATUS] as! NSDictionary
                        let code = status[self.KEY_RESPONSE_CODE] as! String
                        let message = status[self.KEY_RESPONSE_MESSAGE] as! String
                        self.activityIndicator.hideActivityIndicator(uiView: viewController.view)
                        completionHandler(JSON,code,message)
                        
                    }
            }
        }
        else{
            alertView.alert(title: alertView.ALERT_NO_INTERNET, message: "", buttonTitle: alertView.ALERT_OK, controller: viewController)
        }
        
        
    }
    
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
}
