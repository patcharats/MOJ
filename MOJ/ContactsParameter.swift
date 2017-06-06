//
//  ContactsParameter.swift
//  MOJ
//
//  Created by patcharat on 5/3/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import Alamofire

class ContactsParameter: NSObject {
    
    let stringHelper = StringHelper()
    let accountData = AccountData()

    var contactid:String = ""
    var contactuserid:String = ""
    var username:String = ""
    var ipaddr:String = ""
    var devicename:String = ""
    var subject:String = ""
    var contentmsg:String = ""
    var posttime:String = ""
    
    var contact_subject:String = ""
    var contact_body:String = ""
    var isPublicStatus:Bool = true
    
    func registerTalk()->Parameters{
        let parameters: Parameters = [
            "data": [
            ]
        ]
        
        return parameters
    }
    
    
    func getPostReplyParameter()-> Parameters{
        
        
        
        let parameters: Parameters = [
            "data": [
                "contactid": contactid,
                "commentmsg": contentmsg
            ]
        ]
        
        return parameters
        
    }
    
    func getNewPostParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": [
                "contact_subject": contact_subject,
                "contact_body": contact_body,
                "isPublicStatus" : isPublicStatus
            ]
        ]
        return parameters
        
        
    }

}
