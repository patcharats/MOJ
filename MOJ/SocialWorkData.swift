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
    let KEY_REQUEST = "requestData"
    let KEY_READ_ONLY = "readonly"
    let KEY_REQUEST_DATA = "data"
    let KEY_REQUEST_ID = "requestid"
    let KEY_REQUEST_NO = "requestno"
    let KEY_REQUEST_DATE = "requestdate"
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
    let KEY_ADDR_ORG_NO = "addrorgno"
    let KEY_ADDR_ORG_MOO = "addrorgmoo"
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
    
 
    var requestid:String = ""
    var requestno:String = ""
    var requestdate:String = ""
    var requesttype:String = ""
    var idcardno:String = ""
    var issueby:String = ""
    var issuedate:String = ""
    var prename:String = ""
    var firstname:String = ""
    var lastname:String = ""
    var birthdate:String = ""
    var nationality:String = ""
    var maritalstatus:String = ""
    var religion:String = ""
    var addr1no:String = ""
    var addr1moo:String = ""
    var addr1soi:String = ""
    var addr1road:String = ""
    var addr1tumbon:String = ""
    var addr1amphur:String = ""
    var addr1province:String = ""
    var addr1zip:String = ""
    var addr1telephn:String = ""
    var addr2no:String = ""
    var addr2moo:String = ""
    var addr2soi:String = ""
    var addr2road:String = ""
    var addr2tumbon:String = ""
    var addr2amphur:String = ""
    var addr2province:String = ""
    var addr2zip:String = ""
    var addr2telephn:String = ""
    var addr2fax:String = ""
    var addr2mobile:String = ""
    var addr2email:String = ""
    var occupation:String = ""
    var occorgname:String = ""
    var occother:String = ""
    var occlevel:String = ""
    var occposition:String = ""
    var addrorgno:String = ""
    var addrorgmoo:String = ""
    var addrorgsoi:String = ""
    var addrorroad:String = ""
    var addrortumbon:String = ""
    var addroramphur:String = ""
    var addrorprovince:String = ""
    var addrorzip:String = ""
    var orgadphone:String = ""
    var orgadfax:String = ""
    var orgadmobile:String = ""
    var degree:String = ""
    var major:String = ""
    var study:String = ""
    
    var studyother:String = ""
    var faculty:String = ""
    var institution:String = ""
    var graduateyear:String = ""
    var workarea:String = ""
    var province1:String = ""
    var province2:String = ""
    var province3:String = ""
    
    var training:String = ""
    var trainby:String = ""
    var traindate:String = ""
    var lastworkorg:String = ""
    var lastorgstart:String = ""
    var lastorgend:String = ""
    var lastorgdetail:String = ""
    var checkdoc:String = ""
    var confirmdata:String = ""
    var provlatedoc:String = ""
    
    var notapprove:String = ""
    var approvedate:String = ""
    var postponestatus:String = ""
    
    var readOnly:Bool = false
    
    func setReadOnly(isReadOnly:Bool){
        userdefault.set(isReadOnly, forKey: KEY_READ_ONLY)
    }
    
    func isReadOnly()->Bool{
        return userdefault.bool(forKey: KEY_READ_ONLY)
        
    }
    
    func setData(json:JSON){
        userdefault.set(json.rawString(), forKey: KEY_REQUEST)
        //userdefault.set(json, forKey:KEY_REQUEST)
    }
 
    public func getData() -> JSON {
        return JSON.parse(userdefault.value(forKey:KEY_REQUEST) as! String)
    }
    
    func getSocialWorkData(json:JSON){
        let swiftyJson = json
        requestid =  swiftyJson[KEY_REQUEST_DATA][KEY_REQUEST_ID].stringValue
        requestno =  swiftyJson[KEY_REQUEST_DATA][KEY_REQUEST_NO].stringValue
        requestdate =  swiftyJson[KEY_REQUEST_DATA][KEY_REQUEST_DATE].stringValue
        requesttype =  swiftyJson[KEY_REQUEST_DATA][KEY_REQUEST_TYPE].stringValue
        idcardno =  swiftyJson[KEY_REQUEST_DATA][KEY_ID_CARD_NO].stringValue
        issueby =  swiftyJson[KEY_REQUEST_DATA][KEY_ISSUE_BY].stringValue
        issuedate =  swiftyJson[KEY_REQUEST_DATA][KEY_ISSUE_DATE].stringValue
        prename =  swiftyJson[KEY_REQUEST_DATA][KEY_PRE_NAME].stringValue
        firstname =  swiftyJson[KEY_REQUEST_DATA][KEY_FIRST_NAME].stringValue
        lastname =  swiftyJson[KEY_REQUEST_DATA][KEY_LAST_NAME].stringValue
        birthdate =  swiftyJson[KEY_REQUEST_DATA][KEY_BIRTH_DATE].stringValue
        nationality =  swiftyJson[KEY_REQUEST_DATA][KEY_NATIONALITY].stringValue
        maritalstatus =  swiftyJson[KEY_REQUEST_DATA][KEY_MARITAL_STATUS].stringValue
        religion =  swiftyJson[KEY_REQUEST_DATA][KEY_RELIGION].stringValue
        addr1no =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_NO].stringValue
        addr1moo =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_MOO].stringValue
        addr1soi =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_SOI].stringValue
        addr1road =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_ROAD].stringValue
        addr1tumbon =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_TUMBON].stringValue
        addr1amphur =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_AMPHUR].stringValue
        addr1province =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_PROVINCE].stringValue
        addr1zip =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_ZIP].stringValue
        addr1telephn =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR1_TELEPHONE].stringValue
        addr2no =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_NO].stringValue
        addr2moo =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_MOO].stringValue
        addr2soi =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_SOI].stringValue
        addr2road =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_ROAD].stringValue
        addr2tumbon =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_TUMBON].stringValue
        addr2amphur =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_AMPHUR].stringValue
        addr2province =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_PROVINCE].stringValue
        addr2zip =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_ZIP].stringValue
        addr2telephn =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_TELEPHONE].stringValue
        addr2fax =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_FAX].stringValue
        addr2mobile =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_MOBILE].stringValue
        addr2email =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR2_EMAIL].stringValue
        occupation =  swiftyJson[KEY_REQUEST_DATA][KEY_OCCUPATION].stringValue
        occorgname =  swiftyJson[KEY_REQUEST_DATA][KEY_OCCORGNAME].stringValue
        occother =  swiftyJson[KEY_REQUEST_DATA][KEY_OCCUTHER].stringValue
        occlevel =  swiftyJson[KEY_REQUEST_DATA][KEY_OCCLEVEL].stringValue
        occposition =  swiftyJson[KEY_REQUEST_DATA][KEY_OCCPOSITION].stringValue
        addrorgno =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_NO].stringValue
        addrorgmoo =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_MOO].stringValue
        addrorgsoi =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_SOI].stringValue
        addrorroad =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_ROAD].stringValue
        addrortumbon =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_TUMBON].stringValue
        addroramphur =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_AMPHUR].stringValue
        addrorprovince =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_PROVINCE].stringValue
        addrorzip =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_ZIP].stringValue
        orgadphone =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_PHONE].stringValue
        orgadfax =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_FAX].stringValue
        orgadmobile =  swiftyJson[KEY_REQUEST_DATA][KEY_ADDR_ORG_MOBILE].stringValue
        degree =  swiftyJson[KEY_REQUEST_DATA][KEY_DEGREE].stringValue
        major =  swiftyJson[KEY_REQUEST_DATA][KEY_MAJOR].stringValue
        study =  swiftyJson[KEY_REQUEST_DATA][KEY_STUDY].stringValue
        studyother =  swiftyJson[KEY_REQUEST_DATA][KEY_STUDY_OTHER].stringValue
        faculty =  swiftyJson[KEY_REQUEST_DATA][KEY_FACULTY].stringValue
        institution =  swiftyJson[KEY_REQUEST_DATA][KEY_INSTITUTION].stringValue
        graduateyear =  swiftyJson[KEY_REQUEST_DATA][KEY_GRADUATE_YEAR].stringValue
//        workarea =  swiftyJson[KEY_REQUEST_DATA][KEY_REQUEST_ID].stringValue
        province1 =  swiftyJson[KEY_REQUEST_DATA][KEY_WORK_AREA][KEY_PROVINCE1].stringValue
        province2 =  swiftyJson[KEY_REQUEST_DATA][KEY_WORK_AREA][KEY_PROVINCE2].stringValue
        province3 =  swiftyJson[KEY_REQUEST_DATA][KEY_WORK_AREA][KEY_PROVINCE3].stringValue
        
        training =  swiftyJson[KEY_REQUEST_DATA][KEY_TRAINING].stringValue
        trainby =  swiftyJson[KEY_REQUEST_DATA][KEY_TRAIN_BY].stringValue
        traindate =  swiftyJson[KEY_REQUEST_DATA][KEY_TRAIN_DATE].stringValue
        lastworkorg =  swiftyJson[KEY_REQUEST_DATA][KEY_LAST_WORK_ORG].stringValue
        lastorgstart =  swiftyJson[KEY_REQUEST_DATA][KEY_LAST_ORG_START].stringValue
        lastorgend =  swiftyJson[KEY_REQUEST_DATA][KEY_LAST_ORG_END].stringValue
        lastorgdetail =  swiftyJson[KEY_REQUEST_DATA][KEY_LAST_ORG_DETAIL].stringValue
        checkdoc =  swiftyJson[KEY_REQUEST_DATA][KEY_CHECK_DOC].stringValue
        confirmdata =  swiftyJson[KEY_REQUEST_DATA][KEY_CONFIRM_DATE].stringValue
        provlatedoc =  swiftyJson[KEY_REQUEST_DATA][KEY_PROV_LATE_DOC].stringValue
        
        notapprove =  swiftyJson[KEY_REQUEST_DATA][KEY_NOT_APPROVE].stringValue
        approvedate =  swiftyJson[KEY_REQUEST_DATA][KEY_APPROVE_DATE].stringValue
        postponestatus =  swiftyJson[KEY_REQUEST_DATA][KEY_POSTPONE_STATUS].stringValue

    }
    

}
