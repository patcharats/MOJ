//
//  SocialWorkData.swift
//  MOJ
//
//  Created by patcharat on 5/17/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON

class SocialWorkData: NSObject {
    
    var userdefault = UserDefaults.standard
    let KEY_REQUEST_ID = "requestid"
    let KEY_REQUEST_NO = "requestno"
    let KEY_REQUEST_DATA = "requestdate"
    let KEY_REQUEST_TYPE = "requesttype"
    let KEY_ID_CARD_NO = "idcardno"
    let KEY_ISSUE_BY = "issueby"
    let KEY_ISSUE_DATE = "issuedate"
    let KEY_PRE_NAME = "prename"
    let KEY_FIRST_NAME = "firstname"
    let KEY_LAST_NAME = "lastname"
    let KEY_BIRTH_DATE = "birthdate"
    let KEY_NATIONALITY = "nationality"
    let KEY_MARITAL_STATUS = "maritalstatus"
    let KEY_RELIGION = "religion"
    let KEY_ADDR1_NO = "addr1no"
    let KEY_ADDR1_MOO = "addr1moo"
    let KEY_ADDR1_SOI = "addr1soi"
    let KEY_ADDR1_ROAD = "addr1road"
    let KEY_ADDR1_TUMBON = "addr1tumbon"
    let KEY_ADDR1_AMPHUR = "addr1amphur"
    let KEY_ADDR1_PROVINCE = "addr1province"
    let KEY_ADDR1_ZIP = "addr1zip"
    let KEY_ADDR1_TELEPHONE = "addr1telephn"
    let KEY_ADDR2_NO = "addr2no"
    let KEY_ADDR2_MOO = "addr2moo"
    let KEY_ADDR2_SOI = "addr2soi"
    let KEY_ADDR2_ROAD = "addr2road"
    let KEY_ADDR2_TUMBON = "addr2tumbon"
    let KEY_ADDR2_AMPHUR = "addr2amphur"
    let KEY_ADDR2_PROVINCE = "addr2province"
    let KEY_ADDR2_ZIP = "addr2zip"
    let KEY_ADDR2_TELEPHONE = "addr2telephn"
    let KEY_ADDR2_FAX = "addr2fax"
    let KEY_ADDR2_MOBILE = "addr2mobile"
    let KEY_ADDR2_EMAIL = "addr2email"
    let KEY_OCCUPATION = "occupation"
    let KEY_OCCORGNAME = "occorgname"
    let KEY_OCCUTHER = "occother"
    let KEY_OCCLEVEL = "occlevel"
    let KEY_OCCPOSITION = "occposition"
    let KEY_ADDRORGNO = "addrorgno"
    let KEY_ADDR_TOTGMOO = "addrorgmoo"
    let KEY_ADDR_ORG_SOI = "addrorgsoi"
    let KEY_ADDR_ORG_ROAD = "addrorroad"
    let KEY_ADDR_ORG_TUMBON = "addrortumbon"
    let KEY_ADDR_ORG_AMPHUR = "addroramphur"
    let KEY_ADDR_ORG_PROVINCE = "addrorprovince"
    let KEY_ADDR_ORG_ZIP = "addrorzip"
    let KEY_ADDR_ORG_PHONE = "orgadphone"
    let KEY_ADDR_ORG_FAX = "orgadfax"
    let KEY_ADDR_ORG_MOBILE = "orgadmobile"
    let KEY_DEGREE = "degree"
    let KEY_MAJOR = "major"
    let KEY_STUDY = "study"
    
    let KEY_STUDY_OTHER = "studyother"
    let KEY_FACULTY = "faculty"
    let KEY_INSTITUTION = "institution"
    let KEY_GRADUATE_YEAR = "graduateyear"
    let KEY_WORK_AREA = "workarea"
    let KEY_PROVINCE1 = "province1"
    let KEY_PROVINCE2 = "province2"
    let KEY_PROVINCE3 = "province3"
    
    let KEY_TRAINING = "training"
    let KEY_TRAIN_BY = "trainby"
    let KEY_TRAIN_DATE = "traindate"
    let KEY_LAST_WORK_ORG = "lastworkorg"
    let KEY_LAST_ORG_START = "lastorgstart"
    let KEY_LAST_ORG_END = "lastorgend"
    let KEY_LAST_ORG_DETAIL = "lastorgdetail"
    let KEY_CHECK_DOC = "checkdoc"
    let KEY_CONFIRM_DATE = "confirmdata"
    let KEY_PROV_LATE_DOC = "provlatedoc"
    
    let KEY_NOT_APPROVE = "notapprove"
    let KEY_APPROVE_DATE = "approvedate"
    let KEY_POSTPONE_STATUS = "postponestatus"
    
    
    func getSocialWorkData(json:Any){
        let swiftyJson = JSON(json)
        
    }
    

}
