//
//  FacebookData.swift
//  test
//
//  Created by CBK-Admin on 4/19/2560 BE.
//
//

import UIKit
import SwiftyJSON

class FacebookData: NSObject {
    
    let KEY_EMAIL = "email"
    let KEY_FIRST_NAME = "first_name"
    let KEY_ID = "id"
    let KEY_NAME = "name"
    let KEY_PICTURE = "picture"

    var facebookToken:String? = nil
    var facebookEmail:String? = nil
    var facebookFirstName:String? = nil
    var facebookID:String? = nil
    var facebookName:String? = nil
    
    func getFacebookData(json:Any){
     
        let swiftyJson = JSON(json)
        facebookEmail = swiftyJson[KEY_EMAIL].stringValue
        facebookFirstName = swiftyJson[KEY_FIRST_NAME].stringValue
        facebookID = swiftyJson[KEY_ID].stringValue
        facebookName = swiftyJson[KEY_NAME].stringValue
        
        print("facebook :\(swiftyJson)")
        
    }
}
