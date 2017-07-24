//
//  AccountData.swift
//  test
//
//  Created by CBK-Admin on 4/19/2560 BE.
//
//

import UIKit
import SwiftyJSON
class AccountData: NSObject {

    var userdefault = UserDefaults.standard
    let KEY_ACCOUNT_ID = "accountid"
    let KEY_ACCOUNT_EMAIL = "email"
    let KEY_ACCOUNT_FIRST_NAME = "firstname"
    let KEY_ACCOUNT_LAST_NAME = "lastname"
    let KEY_ACCOUNT_PHONE_NO = "phoneno"
    let KEY_ACCOUNT_LAST_LOGIN = "lastlogin"
    let KEY_ACCOUNT_TOKEN = "token"
    let KEY_ACCOUNT_COMPLAINT_STATUS = "complt_status"
    let KEY_ACCOUNT_SOCIAL_STATUS = "socwrk_status"
    let KEY_ACCOUNT_USER_LEVEL = "userlevel"
    let KEY_ACCOUNT_CHANNEL = "channel"
    
    let KEY_ACCOUNT_DATA = "data"
    let KEY_ACCOUNT_ACCOUNT = "account"
    
    let KEY_IS_SHOW_HOWTO = "isShow"
    let KEY_IS_LOGIN = "isLogin"
    let KEY_IS_ADMIN = "isAdmin"

    
    func getAccountData(json:Any){
        
        let swiftyJson = JSON(json)
        
        let data = swiftyJson[KEY_ACCOUNT_DATA].dictionary
        let account = data?[KEY_ACCOUNT_ACCOUNT]?.dictionary
        let accountID = account?[KEY_ACCOUNT_ID]?.stringValue
        let accountEmail = account?[KEY_ACCOUNT_EMAIL]?.stringValue
        let accountFirstName = account?[KEY_ACCOUNT_FIRST_NAME]?.stringValue
        let accountLastName = account?[KEY_ACCOUNT_LAST_NAME]?.stringValue
        
        if var accountPhoneNo = account?[KEY_ACCOUNT_PHONE_NO]?.stringValue{
            accountPhoneNo = ""
            setAccountPhoneNo(accountPhoneNo: accountPhoneNo)
        }
        
        let accountToken = data?[KEY_ACCOUNT_TOKEN]?.stringValue
        let accountLastLogin = data?[KEY_ACCOUNT_LAST_LOGIN]?.stringValue
        
        let accountComplaintStatus = account?[KEY_ACCOUNT_COMPLAINT_STATUS]?.int
        let accountSocialStatus = account?[KEY_ACCOUNT_SOCIAL_STATUS]?.int
        let accountUserLevel = account?[KEY_ACCOUNT_USER_LEVEL]?.stringValue
        
        let accountChannel = account?[KEY_ACCOUNT_CHANNEL]?.stringValue
        
        if accountUserLevel == "0" {
            setAdmin(isAdmin: false)
        }
        else{
            setAdmin(isAdmin: true)
        }
        
        if accountSocialStatus == 0 {
            setSocialWork(hasSocialWork: false)
        }
        else{
            setSocialWork(hasSocialWork: true)
        }
        
        print(accountComplaintStatus!)
        
        if accountComplaintStatus == 0 {
            setComplaintStatus(hasComplaintStatus: false)
        }
        else{
            setComplaintStatus(hasComplaintStatus: true)
        }
        
        setLogin(isLogin: true)
        setShowHowto(isShowHowto: true)
        setAccountID(accountID: accountID!)
        setAccountEmail(accountEmail: accountEmail!)
        setAccountFirstName(accountFirstName: accountFirstName!)
        setAccountLastName(accountFirstName: accountLastName!)
        setAccountToken(accountToken: accountToken!)
        setAccountLastLogin(accountLastlogin: accountLastLogin!)
        setAccountChannel(accountChannel: accountChannel!)
        
        
        print("accountid :\(accountID!)")
        print("accountToken :\(accountToken!)")
    }
    
    // isShow
    
    func setShowHowto(isShowHowto:Bool){
        userdefault.set(isShowHowto, forKey: KEY_IS_SHOW_HOWTO)
    }
    
    func isShowHowto()->Bool{
        return userdefault.bool(forKey: KEY_IS_SHOW_HOWTO)
        
    }
    
    // isLogin
    
    func setLogin(isLogin:Bool){
        userdefault.set(isLogin, forKey: KEY_IS_LOGIN)
    }
    
    func isLogin()->Bool{
        return userdefault.bool(forKey: KEY_IS_LOGIN)
        
    }
    
    // hasComplaintStatus
    
    func setComplaintStatus(hasComplaintStatus:Bool){
        userdefault.set(hasComplaintStatus, forKey: KEY_ACCOUNT_COMPLAINT_STATUS)
    }
    
    func getComplaintStatus()->Bool{
        return userdefault.bool(forKey: KEY_ACCOUNT_COMPLAINT_STATUS)
    }
    
    
    
    // hasSocialWork
    
    func setSocialWork(hasSocialWork:Bool){
        userdefault.set(hasSocialWork, forKey: KEY_ACCOUNT_SOCIAL_STATUS)
    }
    
    func getSocialWork()->Bool{
        return userdefault.bool(forKey: KEY_ACCOUNT_SOCIAL_STATUS)
    }
    
    // isAdmin
    
    func setAdmin(isAdmin:Bool){
        userdefault.set(isAdmin, forKey: KEY_IS_ADMIN)
    }
    
    func isAdmin()->Bool{
        return userdefault.bool(forKey: KEY_IS_ADMIN)
    }
    
    // AccountID
    
    func setAccountID(accountID:String){
        userdefault.set(accountID, forKey: KEY_ACCOUNT_ID)
    }
    
    func getAccountID()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_ID) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_ID) as! String
        }
        
        return "0"
    }
    
    // AccountEmail
    
    func setAccountEmail(accountEmail:String){
        userdefault.set(accountEmail, forKey: KEY_ACCOUNT_EMAIL)
    }
    
    func getAccountEmail()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_EMAIL) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_EMAIL) as! String
        }
        
        return ""
    }
    
    // AccountFirstname

    func setAccountFirstName(accountFirstName:String){
        userdefault.set(accountFirstName, forKey: KEY_ACCOUNT_FIRST_NAME)
    }
    
    func getAccountFirstName()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_FIRST_NAME) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_FIRST_NAME) as! String
        }
        
        return ""
    }
    
    // AccountLastname
    
    func setAccountLastName(accountFirstName:String){
        userdefault.set(accountFirstName, forKey: KEY_ACCOUNT_LAST_NAME)
    }
    
    func getAccountLastName()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_LAST_NAME) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_LAST_NAME) as! String
        }
        
        return ""
    }
    
    // AccountPhoneNo
    
    func setAccountPhoneNo(accountPhoneNo:String){
        userdefault.set(accountPhoneNo, forKey: KEY_ACCOUNT_PHONE_NO)
    }
    
    func getAccountPhoneNo()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_PHONE_NO) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_PHONE_NO) as! String
        }
        
        return ""
    }
    
    // AccountToken
    
    func setAccountToken(accountToken:String){
        userdefault.set(accountToken, forKey: KEY_ACCOUNT_TOKEN)
    }
    
    func getAccountToken()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_TOKEN) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_TOKEN) as! String
        }
        
        return ""
    }
    
    // AccountLastLogin
    
    func setAccountLastLogin(accountLastlogin:String){
        userdefault.set(accountLastlogin, forKey: KEY_ACCOUNT_LAST_LOGIN)
    }
    
    func getAccountLastLogin()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_LAST_LOGIN) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_LAST_LOGIN) as! String
        }
        
        return ""
    }
    
    
    // Channel
    
    func setAccountChannel(accountChannel:String){
        userdefault.set(accountChannel, forKey: KEY_ACCOUNT_CHANNEL)
    }
    
    func getAccountChannel()->String{
        
        if userdefault.value(forKey: KEY_ACCOUNT_CHANNEL) != nil{
            return userdefault.value(forKey: KEY_ACCOUNT_CHANNEL) as! String
        }
        
        return "0"
    }
    
}
