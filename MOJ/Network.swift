//
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
    let KEY_RESPONSE_STATUS = "status"
    let KEY_RESPONSE_CODE = "code"
    let KEY_RESPONSE_MESSAGE = "message"
    
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
    let activityIndicator = ActivityIndicatorView()
    
    func post(name:String,param:Parameters,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        
        
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
//            "Accept": "application/json"
//        ]
//        
//        Alamofire.request("https://httpbin.org/headers", headers: headers).responseJSON { response in
//            debugPrint(response)
//        }
        
        
        print("******** api :\(self.API_BASE_URL+name)")
        activityIndicator.showActivityIndicator(uiView: viewController.view)
        Alamofire.request(API_BASE_URL+name, method: .post, parameters: param, encoding: JSONEncoding.default)
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
    
    func get(name:String,param:String,viewController:UIViewController,completionHandler:@escaping (Any,String,String) -> ()){
        
        print("******** api :\(self.API_BASE_URL+name+param)")
        activityIndicator.showActivityIndicator(uiView: viewController.view)
        Alamofire.request(API_BASE_URL+name+param, method: .get)
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
