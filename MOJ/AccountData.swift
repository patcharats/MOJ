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
    
    let KEY_CUSTOMER_ADDRESS = "customer_address"
    let KEY_ADDRESS = "address"
    let KEY_TUMBON = "address_tumbon"
    let KEY_AMPHUR = "address_amphur"
    let KEY_PROVINCE = "address_province"
    let KEY_ZIP = "address_zip"
    
    let KEY_TUMBON_ID = "address_tumbon_id"
    let KEY_AMPHUR_ID = "address_amphur_id"
    let KEY_PROVINCE_ID = "address_province_id"
    
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
        
//        let address = account?[KEY_CUSTOMER_ADDRESS]?[KEY_ADDRESS].stringValue
//        let addressProvince = account?[KEY_CUSTOMER_ADDRESS]?[KEY_PROVINCE].stringValue
//        let addressAmphur = account?[KEY_CUSTOMER_ADDRESS]?[KEY_AMPHUR].stringValue
//        let addressTambon = account?[KEY_CUSTOMER_ADDRESS]?[KEY_TUMBON].stringValue
//        let addressZip = account?[KEY_CUSTOMER_ADDRESS]?[KEY_ZIP].stringValue
//        
//        setAddress(address: address!)
//        setAddressProvince(address: addressProvince!)
//        setAddressAmphur(address: addressAmphur!)
//        setAddressTambon(address: addressTambon!)
//        setAddressZip(address: addressZip!)
        
        print("accountid :\(accountID!)")
        print("accountToken :\(accountToken!)")
    }
    
    
    // Address
    func setAddress(address:String){
        userdefault.set(address, forKey: KEY_ADDRESS)
    }
    func getAddress()->String{
        
        if userdefault.value(forKey: KEY_ADDRESS) != nil{
            return userdefault.value(forKey: KEY_ADDRESS) as! String
        }
        return ""
    }
    
    // Address
    func setAddressProvince(address:String){
        userdefault.set(address, forKey: KEY_PROVINCE)
    }
    func getAddressProvince()->String{
        
        if userdefault.value(forKey: KEY_PROVINCE) != nil{
            return userdefault.value(forKey: KEY_PROVINCE) as! String
        }
        return ""
    }
    
    // Address
    func setAddressProvinceID(address:String){
        userdefault.set(address, forKey: KEY_PROVINCE_ID)
    }
    func getAddressProvinceID()->String{
        
        if userdefault.value(forKey: KEY_PROVINCE_ID) != nil{
            return userdefault.value(forKey: KEY_PROVINCE_ID) as! String
        }
        return "0"
    }
    
    
    // Address
    func setAddressAmphur(address:String){
        userdefault.set(address, forKey: KEY_AMPHUR)
    }
    func getAddressAmphur()->String{
        
        if userdefault.value(forKey: KEY_AMPHUR) != nil{
            return userdefault.value(forKey: KEY_AMPHUR) as! String
        }
        return ""
    }
    
    // Address
    func setAddressAmphurID(address:String){
        userdefault.set(address, forKey: KEY_AMPHUR_ID)
    }
    func getAddressAmphurID()->String{
        
        if userdefault.value(forKey: KEY_AMPHUR_ID) != nil{
            return userdefault.value(forKey: KEY_AMPHUR_ID) as! String
        }
        return "0"
    }
    
    
    // Address
    func setAddressTambon(address:String){
        userdefault.set(address, forKey: KEY_TUMBON)
    }
    func getAddressTambon()->String{
        
        if userdefault.value(forKey: KEY_TUMBON) != nil{
            return userdefault.value(forKey: KEY_TUMBON) as! String
        }
        return ""
    }
    
    
    func setAddressTambonID(address:String){
        userdefault.set(address, forKey: KEY_TUMBON_ID)
    }
    func getAddressTambonID()->String{
        
        if userdefault.value(forKey: KEY_TUMBON_ID) != nil{
            return userdefault.value(forKey: KEY_TUMBON_ID) as! String
        }
        return "0"
    }
    
    
    // Address
    func setAddressZip(address:String){
        userdefault.set(address, forKey: KEY_ZIP)
    }
    func getAddressZip()->String{
        
        if userdefault.value(forKey: KEY_ZIP) != nil{
            return userdefault.value(forKey: KEY_ZIP) as! String
        }
        return ""
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
