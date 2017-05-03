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
    
    func getCreateComplaintParameter()-> Parameters{
        let parameters: Parameters = [
            "data": ["accountid":accountData.getAccountID(),
                     "cmpltservguide": cmpltservguide,
                     "cmpltsubject": cmpltsubject,
                     "cmpltcontent": cmpltcontent,
                     "cmpltstatus": cmpltstatus,
                     "cmpltinstget": cmpltinstget,
                     "posttime": stringHelper.getCurrentDateTimeString(),
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
                     "laser": laser
            ]
        ]
        return parameters

    }
}


