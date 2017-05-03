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
//        let accountPhoneNo = account?[KEY_ACCOUNT_PHONE_NO]?.stringValue
        
        let accountToken = data?[KEY_ACCOUNT_TOKEN]?.stringValue
        let accountLastLogin = data?[KEY_ACCOUNT_LAST_LOGIN]?.stringValue
        
        setLogin(isLogin: true)
        setAdmin(isAdmin: false)
        setAccountID(accountID: accountID!)
        setAccountEmail(accountEmail: accountEmail!)
        setAccountFirstName(accountFirstName: accountFirstName!)
        setAccountLastName(accountFirstName: accountLastName!)
        setAccountToken(accountToken: accountToken!)
        setAccountLastLogin(accountLastlogin: accountLastLogin!)
//        setAccountPhoneNo(accountPhoneNo: accountPhoneNo!)
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
    
}
