//
//  ComplaintParameter.swift
//  MOJ
//
//  Created by patcharat on 4/27/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import Alamofire

class ComplaintParameter: NSObject {
    
    let stringHelper = StringHelper()
    let accountData = AccountData()
    
    var cmpltservguide:Int = 0
    var cmpltsubject:String = ""
    var cmpltcontent:String = ""
    var cmpltstatus:String = ""
    var cmpltinstget:String = ""
    
    var pid:String = ""
    var prename:String = ""
    var firstname:String = ""
    var lastname:String = ""
    var birthdate:String = ""
    var laser:String = ""
    
    var cmpltid:String = ""
    var cmpltuserid:String = ""
    
    var address:String? = ""
    var address_tumbon:String? = ""
    var address_amphur:String? = ""
    var address_province:String? = ""
    var address_zip:String? = ""
    
    func getCreateComplaintParameter()-> Parameters{
        let parameters: Parameters = [
            "data": ["accountid":accountData.getAccountID(),
                     "cmpltservguide": cmpltservguide,
                     "cmpltsubject": cmpltsubject,
                     "cmpltcontent": cmpltcontent,
                     "cmpltstatus": cmpltstatus,
                     "cmpltinstget": cmpltinstget,
                     "posttime": stringHelper.getCurrentDateTimeString(),
                     "address": address!,
                     "address_tumbon": address_tumbon!,
                     "address_amphur": address_amphur!,
                     "address_province": address_province!,
                     "address_zip": address_zip!
            ]
        ]
        return parameters
        
    }
    
    
    func getVerifyIDParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": ["pid":pid,
                     "prename": prename,
                     "firstname": accountData.getAccountFirstName(),
                     "lastname": accountData.getAccountLastName(),
                     "birthdate": birthdate,
                     "laser": laser,
                     "address": address!,
                     "address_tumbon": address_tumbon!,
                     "address_amphur": address_amphur!,
                     "address_province": address_province!,
                     "address_zip": address_zip!
            ]
        ]
        return parameters

    }
    
    
    func getUploadImageParameter()-> NSDictionary{
        let parameters: NSDictionary = [
            "data": ["cmpltid":cmpltid,
                     "cmpltuserid": cmpltuserid
            ]
        ]
        return parameters
        
    }
    
    
}


