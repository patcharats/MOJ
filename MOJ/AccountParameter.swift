//
//  AccountParameter.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AccountParameter: NSObject {
    
    var username:String? = ""
    var password:String? = ""
    var facebook_token:String? = ""
    var channal:String? = ""
    var firstname:String? = ""
    var lastname:String? = ""
    var email:String? = ""
    var phoneno:String? = ""
    var old_password:String? = ""
    var new_password:String? = ""
    var confirm_new_password:String? = ""
    
    var address:String? = ""
    var address_tumbon:String? = ""
    var address_amphur:String? = ""
    var address_province:String? = ""
    var address_zip:String? = ""
    
    func getLoginParameter() -> Parameters{
        
        let parameters: Parameters = [
            "data": ["username": username!,
                     "password": password!,
                     "channel": channal!,
                     "facebook_token":facebook_token!,
                     "device": getDevice()
            ]
        ]
        return parameters
    }
    
    func getRegisterParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": ["username": username!,
                     "password": password!,
                     "facebook_token":facebook_token!,
                     "channel": channal!,
                     "account": [
                        "firstname": firstname,
                        "lastname": lastname,
                        "email": email,
                        "phoneno": phoneno],
                     "device": getDevice()
            ]
        ]
        return parameters
        
    }
    
    func getUpdateProfileParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": ["account": [
                "firstname": firstname!,
                "lastname": lastname!,
                "email": email!,
                "phoneno": phoneno!,
                "address": address!,
                "address_tumbon": address_tumbon!,
                "address_amphur": address_amphur!,
                "address_province": address_province!,
                "address_zip": address_zip!
                ],
                     "device": getDevice()
            ]
        ]
        return parameters
        
    }
    
    func getForgetPasswordParameter()-> Parameters{
        let parameters: Parameters = [
            "data": [
                "email": email
            ]
        ]
        return parameters
        
    }
    
    func getChangePasswordParameter()-> Parameters{
        let parameters: Parameters = [
            "data": [
                "old_password": old_password,
                "new_password": new_password,
                "confirm_new_password": confirm_new_password
            ]
        ]
        return parameters
        
    }
    
    func getDevice()->NSDictionary{
        
        let device:NSDictionary = [
            "imei": getImei(),
            "devicetype": "",
            "machine": "",
            "screensize": "",
            "manufacture": "",
            "os": "",
            "locale": "",
            "lat": "",
            "lng": "",
            "country": "",
            "carriercountry": "",
            "notiToken": ""
        ]
        
        return device
    }
    
    func getImei()->String{
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
}
