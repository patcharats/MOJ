//
//  PsychoParameter.swift
//  MOJ
//
//  Created by patcharat on 5/14/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import Alamofire

class PsychoParameter: NSObject {
    
    let stringHelper = StringHelper()
    let accountData = AccountData()
    var search_key:String = ""
    
    var addr1moo = ""
    var addr1no = ""
    var addr1road = ""
    var addr1soi = ""
    var addr1telephn = ""
    var addr1zip = ""
    var addr2email = ""
    var addr2fax = ""
    var addr2mobile = ""
    var addr2moo = ""
    var addr2no = ""
    var addr2road = ""
    var addr2soi = ""
    var addr2telephn = ""
    var addr2zip = ""
    var addrorgmoo = ""
    var addrorgno = ""
    var addrorgsoi = ""
    var addrorroad = ""
    var addrorzip = ""
    var approvedate = ""
    var checkdoc = ""
    var confirmdata = ""
    var faculty = ""
    var firstname = ""
    var graduateyear = ""
    var idcardno = ""
    var institution = ""
    var issueby = ""
    var issuedate = ""
    var expiredate = ""
    var lastname = ""
    var lastorgdetail = ""
    var lastworkorg = ""
    var nationality = ""
    var notapprove = ""
    var occlevel = ""
    var occorgname = ""
    var OccorNocard = ""
    var occother = ""
    var occposition = ""
    var orgadfax = ""
    var orgadmobile = ""
    var orgadphone = ""
    var postponestatus = ""
    var provlatedoc = ""
    var reqstatus = ""
    var requestdate = ""
    var requestid = ""
    var requestno = ""
    var requesttype = ""
    var studyother = ""
    var trainby = ""

    var province1id = 0
    var province2id = 0
    var province3id = 0
    var province1 = ""
    var province2 = ""
    var province3 = ""
    
    var wf_type = ""
    
    var addr1amphurid = 0
    var addr1provinceid = 0
    var addr1tumbonid = 0
    var addr2amphurid = 0
    var addr2provinceid = 0
    var addr2tumbonid = 0
    var addroramphurid = 0
    var addrorprovinceid = 0
    var addrortumbonid = 0
    var cardtypeid = 0
    var degreeid = 0
    var majorid = 0
    var maritalstatusid = 0
    var occupationid = 0
    var prenameid = 0
    var religionid = 0
    var studyid = 0
    var trainingid = 0
    
    
    var workyear:[String] = []
    var workcountcase:[String] = []
    var workprovince:[String] = []
    var workprovinceid:[String] = []
    
    var REQUEST_TYPE_NEW = "new"
    var REQUEST_TYPE_RENEW = "renew"
    
    var approve = ""
    var noapprvreason = ""
    
    func getApproveParameter()->Parameters{
        
        let parameters: Parameters = [
            "data": [
                "requestid": requestid,
                "approve": approve,
                "noapprvreason": noapprvreason
            ]
        ]
        return parameters
    }
    
    func getSearchParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": [
                "search_key": search_key
            ]
        ]
        return parameters
    }
    
    
    func getCreatePsychoParameter()-> Parameters{
        let parameters: Parameters = [
            "data": [
                "addr1moo": addr1moo,
                "addr1no": addr1no,
                "addr1road": addr1road,
                "addr1soi": addr1soi,
                "addr1telephn": addr1telephn,
                "addr1zip": addr1zip,
                "addr2email": addr2email,
                "addr2fax": addr2fax,
                "addr2mobile": addr2mobile,
                "addr2moo": addr2moo,
                "addr2no": addr2no,
                "addr2road": addr2road,
                "addr2soi": addr2soi,
                "addr2telephn": addr2telephn,
                "addr2zip": addr2zip,
                "addrorgmoo": addrorgmoo,
                "addrorgno": addrorgno,
                "addrorgsoi": addrorgsoi,
                "addrorroad": addrorroad,
                "addrorzip": addrorzip,
                "approvedate": approvedate,
                "checkdoc": checkdoc,
                "confirmdata": confirmdata,
                "faculty": faculty,
                "firstname": firstname,
                "graduateyear": graduateyear,
                "idcardno": idcardno,
                "institution": institution,
                "issueby": issueby,
                "issuedate": issuedate,
                "expiredate": expiredate,
                "lastname": lastname,
                "lastorgdetail": lastorgdetail,
                "lastworkorg": lastworkorg,
                "nationality": nationality,
                "notapprove": notapprove,
                "occlevel": occlevel,
                "occorgname": occorgname,
                "OccorNocard" : OccorNocard,
                "occother": occother,
                "occposition": occposition,
                "orgadfax": orgadfax,
                "orgadmobile": orgadmobile,
                "orgadphone": orgadphone,
                "postponestatus": postponestatus,
                "provlatedoc": provlatedoc,
                "reqstatus": reqstatus,
                "requestdate": requestdate,
                "requestid": requestid,
                "requestno": requestno,
                "requesttype": REQUEST_TYPE_NEW,
                "studyother": studyother,
                "trainby": trainby,
                "workarea": [
                    "province1id": province1id,
                    "province2id": province2id,
                    "province3id": province3id,
                    "province1": province1,
                    "province2": province2,
                    "province3": province3
                ],
                "addr1amphurid": addr1amphurid,
                "addr1provinceid": addr1provinceid,
                "addr1tumbonid": addr1tumbonid,
                "addr2amphurid": addr2amphurid,
                "addr2provinceid": addr2provinceid,
                "addr2tumbonid": addr2tumbonid,
                "addroramphurid": addroramphurid,
                "addrorprovinceid": addrorprovinceid,
                "addrortumbonid": addrortumbonid,
                //"cardtypeid": cardtypeid,
                "degreeid": degreeid,
                "majorid": majorid,
                "maritalstatusid": maritalstatusid,
                "occupationid": occupationid,
                "prenameid": prenameid,
                "religionid": religionid,
                "studyid": studyid,
                "trainingid": trainingid,
                "wf_type":wf_type
            ]
        ]
        return parameters
    }

    
    
    func getReNewPsychoParameter()-> Parameters{
        let parameters: Parameters = [
            "data": [
                "addr1moo": addr1moo,
                "addr1no": addr1no,
                "addr1road": addr1road,
                "addr1soi": addr1soi,
                "addr1telephn": addr1telephn,
                "addr1zip": addr1zip,
                "addr2email": addr2email,
                "addr2fax": addr2fax,
                "addr2mobile": addr2mobile,
                "addr2moo": addr2moo,
                "addr2no": addr2no,
                "addr2road": addr2road,
                "addr2soi": addr2soi,
                "addr2telephn": addr2telephn,
                "addr2zip": addr2zip,
                "addrorgmoo": addrorgmoo,
                "addrorgno": addrorgno,
                "addrorgsoi": addrorgsoi,
                "addrorroad": addrorroad,
                "addrorzip": addrorzip,
                "firstname": firstname,
                "idcardno": idcardno,
                "issueby": issueby,
                "lastname": lastname,
                "nationality": nationality,
                "occlevel": occlevel,
                "occorgname": occorgname,
                "occother": occother,
                "occposition": occposition,
                "orgadfax": orgadfax,
                "orgadmobile": orgadmobile,
                "orgadphone": orgadphone,
                "requestdate": requestdate,
                "requestid": requestid,
                "requestno": requestno,
                "requesttype": REQUEST_TYPE_RENEW,
                "work": getWorksArray(),
                "workarea": [
                    "province1id": province1id,
                    "province2id": province2id,
                    "province3id": province3id,
                    "province1": province1,
                    "province2": province2,
                    "province3": province3
                ],
                "addr1amphurid": addr1amphurid,
                "addr1provinceid": addr1provinceid,
                "addr1tumbonid": addr1tumbonid,
                "addr2amphurid": addr2amphurid,
                "addr2provinceid": addr2provinceid,
                "addr2tumbonid": addr2tumbonid,
                "addroramphurid": addroramphurid,
                "addrorprovinceid": addrorprovinceid,
                "addrortumbonid": addrortumbonid,
                //"cardtypeid": cardtypeid,
                "maritalstatusid": maritalstatusid,
                "occupationid": occupationid,
                "prenameid": prenameid,
                "religionid": religionid
            ]
        ]
        return parameters
    }
    
    func getWorksArray()->[[String:String]]{
        
        var workArray:[[String:String]] = [[:]]
        
        for (index,_) in workyear.enumerated() {
            
            let array = [
                "workyear": workyear[index],
                "workcountcase": workcountcase[index],
                "workprovince": workprovince[index],
                "workprovinceid": workprovinceid[index]
            ]
            
            workArray.append(array)
        }
        
        return workArray
    }
    
    
    
}

