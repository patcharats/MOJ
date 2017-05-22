//
//  ConfigData.swift
//  MOJ
//
//  Created by CBK-Admin on 5/3/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON

class ConfigData: NSObject {
    
    var network = Network()
    var userdefault = UserDefaults.standard
    let KEY_CONFIG_ID = "id"
    let KEY_CONFIG_NAME = "name"
    let KEY_CONFIG_VALUE = "value"
    let KEY_CONFIG_DATA = "data"
    
    let KEY_CONFIG_BEFORE_EXPIRE = "beforeexpire"
    let KEY_CONFIG_DAY_BEFORE_EXPIRE = "daysbeforeexpire"
    let KEY_CONFIG_MESSAGE = "message"
    let KEY_CONFIG_TEL = "tel"
    
    let KEY_CONFIG_CARD_TYPE = "cardtype"
    
    let KEY_CONFIG_CARD_NAME = "cardname"
    let KEY_CONFIG_DEGREE = "degree"
    let KEY_CONFIG_MAJOR = "major"
    let KEY_CONFIG_FIELDSTUDY = "fieldstudy"
    let KEY_CONFIG_MARITAL_STATUS = "maritalstatus"
    let KEY_CONFIG_NAME_PREFIX = "nameprefix"
    let KEY_CONFIG_OCCUPATION_OPTION = "occupationoption"
    let KEY_CONFIG_RELIGION = "religion"
    let KEY_CONFIG_TRAINING = "training"
    
    let KEY_CONFIG_CARD_ID = "degreeID"
    let KEY_CONFIG_DEGREE_ID = "degreeID"
    let KEY_CONFIG_MAJOR_ID = "majorID"
    let KEY_CONFIG_FIELDSTUDY_ID = "fieldstudyID"
    let KEY_CONFIG_MARITAL_STATUS_ID = "maritalstatusID"
    let KEY_CONFIG_NAME_PREFIX_ID = "nameprefixID"
    let KEY_CONFIG_OCCUPATION_OPTION_ID = "occupationoptionID"
    let KEY_CONFIG_RELIGION_ID = "religionID"
    let KEY_CONFIG_TRAINING_ID = "trainingID"
    
    // province
    let KEY_CONFIG_PROVINCE_GEO_ID = "geo_id"
    let KEY_CONFIG_PROVINCE_ID = "province_id"
    let KEY_CONFIG_PROVINCE_CODE = "province_code"
    let KEY_CONFIG_PROVINCE_NAME = "province_name"
    
    // amphur
    let KEY_CONFIG_AMPHUR_GEO_ID = "geo_id"
    let KEY_CONFIG_AMPHUR_ID = "amphur_id"
    let KEY_CONFIG_AMPHUR_CODE = "amphur_code"
    let KEY_CONFIG_AMPHUR_NAME = "amphur_name"
    
    // district
    let KEY_CONFIG_DISTRICT_GEO_ID = "geo_id"
    let KEY_CONFIG_DISTRICT_ID = "district_id"
    let KEY_CONFIG_DISTRICT_CODE = "district_code"
    let KEY_CONFIG_DISTRICT_NAME = "district_name"
    let KEY_CONFIG_DISTRICT_ZIPCODE = "zipcode"
    
    
    var amphurgeoID:[Int] = []
    var amphurID:[Int] = []
    var amphurCode:[Int] = []
    var amphurName:[String] = []
    var districtgeoID:[Int] = []
    var districtID:[Int] = []
    var districtCode:[Int] = []
    var districtName:[String] = []
    var zipcode:[String] = []
    
    

    
    
    func getConfigProvince(json:Any){
        
        let swiftyJson = JSON(json)

        let provinceGeoID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_PROVINCE_GEO_ID].intValue}))
        let provinceID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_PROVINCE_ID].intValue}))
        let provinceCode =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_PROVINCE_CODE].intValue}))
        let provinceName =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_PROVINCE_NAME].stringValue}))
        
        setGeoID(geoid: provinceGeoID)
        setProvinceID(proid: provinceID)
        setProvinceCode(procode: provinceCode)
        setProvinceName(proname: provinceName)
        
    }
    
    func getConfigAmphur(json:Any){
        
        let swiftyJson = JSON(json)
        
        amphurgeoID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_AMPHUR_GEO_ID].intValue}))
        amphurID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_AMPHUR_ID].intValue}))
        amphurCode =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_AMPHUR_CODE].intValue}))
        amphurName =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_AMPHUR_NAME].stringValue}))
        
        setAmphurGeoID(geoid: amphurgeoID)
        setAmphurID(aumid: amphurID)
        setAmphurCode(aumcode: amphurCode)
        setAmphurName(aumname: amphurName)
        
    }
    
    func getConfigDistrict(json:Any){
        
        let swiftyJson = JSON(json)
        
        districtgeoID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_DISTRICT_GEO_ID].intValue}))
        districtID =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_DISTRICT_ID].intValue}))
        districtCode =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_DISTRICT_CODE].intValue}))
        districtName =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_DISTRICT_NAME].stringValue}))
        zipcode =  (swiftyJson[self.KEY_CONFIG_DATA].arrayValue.map({$0[self.KEY_CONFIG_DISTRICT_ZIPCODE].stringValue}))
        
        setDistrictGeoID(geoid: districtgeoID)
        setDistrictID(disid: districtID)
        setDistrictCode(discode: districtCode)
        setDistrictName(disname: districtName)
        setDistrictZipCode(diszipcode: zipcode)
        
    }
    
    func getConfigData(json:Any){
        
        let swiftyJson = JSON(json)
        
        let data =  swiftyJson[self.KEY_CONFIG_DATA].dictionaryValue
        
        
        let daysbeforeexpire =  swiftyJson[self.KEY_CONFIG_DATA][self.KEY_CONFIG_BEFORE_EXPIRE][self.KEY_CONFIG_DAY_BEFORE_EXPIRE].intValue
        let message =  swiftyJson[self.KEY_CONFIG_DATA][self.KEY_CONFIG_BEFORE_EXPIRE][self.KEY_CONFIG_VALUE].stringValue
        let tel =  swiftyJson[self.KEY_CONFIG_DATA][self.KEY_CONFIG_BEFORE_EXPIRE][self.KEY_CONFIG_VALUE].stringValue
        
        
        let cardID =  (data[self.KEY_CONFIG_CARD_TYPE]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let cardName =  (data[self.KEY_CONFIG_CARD_TYPE]?.arrayValue.map({$0[self.KEY_CONFIG_NAME].stringValue}))!
        
        let degreeID =  (data[self.KEY_CONFIG_DEGREE]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let degreeName =  (data[self.KEY_CONFIG_DEGREE]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        let maritalStatusID =  (data[self.KEY_CONFIG_MARITAL_STATUS]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let maritalStatusName =  (data[self.KEY_CONFIG_MARITAL_STATUS]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        let namePrefixID =  (data[self.KEY_CONFIG_NAME_PREFIX]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let namePrefixName =  (data[self.KEY_CONFIG_NAME_PREFIX]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        
        let occupationOptionID =  (data[self.KEY_CONFIG_OCCUPATION_OPTION]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let occupationOptionName =  (data[self.KEY_CONFIG_OCCUPATION_OPTION]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        let religionID =  (data[self.KEY_CONFIG_RELIGION]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let religionName =  (data[self.KEY_CONFIG_RELIGION]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        let trainingID =  (data[self.KEY_CONFIG_TRAINING]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let trainingName =  (data[self.KEY_CONFIG_TRAINING]?.arrayValue.map({$0[self.KEY_CONFIG_NAME].stringValue}))!
        
        
        let majorID =  (data[self.KEY_CONFIG_MAJOR]?.arrayValue.map({$0[self.KEY_CONFIG_ID].intValue}))!
        let majorName =  (data[self.KEY_CONFIG_MAJOR]?.arrayValue.map({$0[self.KEY_CONFIG_VALUE].stringValue}))!
        
        let fieldStudyID =  (data[self.KEY_CONFIG_MAJOR]?.arrayValue.map({$0[self.KEY_CONFIG_FIELDSTUDY].arrayValue.map({$0[self.KEY_CONFIG_ID].intValue})}))!
        let fieldStudyName =  (data[self.KEY_CONFIG_MAJOR]?.arrayValue.map({$0[self.KEY_CONFIG_FIELDSTUDY].arrayValue.map({$0[self.KEY_CONFIG_NAME].stringValue})}))!
        
        
        setDayBeforeExpire(daybeforeexpire: daysbeforeexpire)
        setMessage(message: message)
        setTel(tel: tel)
        
        setCard(card: cardName)
        setCardID(cardid: cardID)
    
        setDegreeID(degreeid: degreeID)
        setDegree(degree: degreeName)
        
        setMajorID(majorid: majorID)
        setMajor(major: majorName)
        
        setFieldStudyID(fieldstudyid: fieldStudyID)
        setFieldStudy(fieldstudy: fieldStudyName)
        
        setMaritalStatusID(maritalstatusid: maritalStatusID)
        setMaritalStatus(maritalstatus: maritalStatusName)
        
        setOccupationOptionID(occupationoptionid: occupationOptionID)
        setOccupationOption(occupationoption: occupationOptionName)
        
        setNamePrefixID(nameprefixid: namePrefixID)
        setNamePrefix(nameprefix: namePrefixName)
        
        setReligionID(religionid: religionID)
        setReligion(religion: religionName)
        
        setTrainingID(trainingid: trainingID)
        setTraining(training: trainingName)
    }
    
    
    
    // beforeexpire
    
    func setDayBeforeExpire(daybeforeexpire:Int){
        userdefault.set(daybeforeexpire, forKey: KEY_CONFIG_DAY_BEFORE_EXPIRE)
    }
    
    func getDayBeforeExpire()->Int{
        
        if userdefault.value(forKey: KEY_CONFIG_DAY_BEFORE_EXPIRE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DAY_BEFORE_EXPIRE) as! Int
        }
        
        return 0
    }
    
    
    func setMessage(message:String){
        userdefault.set(message, forKey: KEY_CONFIG_MESSAGE)
    }
    
    func getMessage()->String{
        
        if userdefault.value(forKey: KEY_CONFIG_MESSAGE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_MESSAGE) as! String
        }
        
        return ""
    }
    
    
    func setTel(tel:String){
        userdefault.set(tel, forKey: KEY_CONFIG_TEL)
    }
    
    func getTel()->String{
        
        if userdefault.value(forKey: KEY_CONFIG_TEL) != nil{
            return userdefault.value(forKey: KEY_CONFIG_TEL) as! String
        }
        
        return ""
    }
    
    
    
    
    // cardtype
    
    func setCardID(cardid:[Int]){
        userdefault.set(cardid, forKey: KEY_CONFIG_CARD_ID)
    }
    
    func getCardID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_CARD_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_CARD_ID) as! [Int]
        }
        
        return []
    }

    func setCard(card:[String]){
        userdefault.set(card, forKey: KEY_CONFIG_CARD_NAME)
    }
    
    func getCard()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_CARD_NAME) != nil{
            return userdefault.value(forKey: KEY_CONFIG_CARD_NAME) as! [String]
        }
        
        return []
    }
    

    // degree
    
    func setDegreeID(degreeid:[Int]){
        userdefault.set(degreeid, forKey: KEY_CONFIG_DEGREE_ID)
    }
    
    func getDegreeID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_DEGREE_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DEGREE_ID) as! [Int]
        }
        
        return []
    }

    
    
    func setDegree(degree:[String]){
        userdefault.set(degree, forKey: KEY_CONFIG_DEGREE)
    }
    
    func getDegree()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_DEGREE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DEGREE) as! [String]
        }
        
        return []
    }
    
    // major
    
    func setMajorID(majorid:[Int]){
        userdefault.set(majorid, forKey: KEY_CONFIG_MAJOR_ID)
    }
    
    func getMajorID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_MAJOR_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_MAJOR_ID) as! [Int]
        }
        
        return []
    }
    
    
    func setMajor(major:[String]){
        userdefault.set(major, forKey: KEY_CONFIG_MAJOR)
    }
    
    func getMajor()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_MAJOR) != nil{
            return userdefault.value(forKey: KEY_CONFIG_MAJOR) as! [String]
        }
        
        return []
    }
    
    // fieldstudy
    
    func setFieldStudyID(fieldstudyid:[[Int]]){
        userdefault.set(fieldstudyid, forKey: KEY_CONFIG_FIELDSTUDY_ID)
    }
    
    func getFieldStudyID()->[[Int]]{
        
        if userdefault.value(forKey: KEY_CONFIG_FIELDSTUDY_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_FIELDSTUDY_ID) as! [[Int]]
        }
        
        return []
    }
    
    func setFieldStudy(fieldstudy:[[String]]){
        userdefault.set(fieldstudy, forKey: KEY_CONFIG_FIELDSTUDY)
    }
    
    func getFieldStudy()->[[String]]{
        
        if userdefault.value(forKey: KEY_CONFIG_FIELDSTUDY) != nil{
            return userdefault.value(forKey: KEY_CONFIG_FIELDSTUDY) as! [[String]]
        }
        
        return []
    }
    
    // maritalstatus
    
    
    func setMaritalStatusID(maritalstatusid:[Int]){
        userdefault.set(maritalstatusid, forKey: KEY_CONFIG_MARITAL_STATUS_ID)
    }
    
    func getMaritalStatusID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_MARITAL_STATUS_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_MARITAL_STATUS_ID) as! [Int]
        }
        
        return []
    }
    
    
    func setMaritalStatus(maritalstatus:[String]){
        userdefault.set(maritalstatus, forKey: KEY_CONFIG_MARITAL_STATUS)
    }
    
    func getMaritalStatus()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_MARITAL_STATUS) != nil{
            return userdefault.value(forKey: KEY_CONFIG_MARITAL_STATUS) as! [String]
        }
        
        return []
    }
    
    // nameprefix
    
    func setNamePrefixID(nameprefixid:[Int]){
        userdefault.set(nameprefixid, forKey: KEY_CONFIG_NAME_PREFIX_ID)
    }
    
    func getNamePrefixID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_NAME_PREFIX_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_NAME_PREFIX_ID) as! [Int]
        }
        
        return []
    }
    
    func setNamePrefix(nameprefix:[String]){
        userdefault.set(nameprefix, forKey: KEY_CONFIG_NAME_PREFIX)
    }
    
    func getNamePrefix()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_NAME_PREFIX) != nil{
            return userdefault.value(forKey: KEY_CONFIG_NAME_PREFIX) as! [String]
        }
        
        return []
    }

    // occupationoption
    
    func setOccupationOptionID(occupationoptionid:[Int]){
        userdefault.set(occupationoptionid, forKey: KEY_CONFIG_OCCUPATION_OPTION_ID)
    }
    
    func getOccupationOptionID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_OCCUPATION_OPTION_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_OCCUPATION_OPTION_ID) as! [Int]
        }
        
        return []
    }
    
    func setOccupationOption(occupationoption:[String]){
        userdefault.set(occupationoption, forKey: KEY_CONFIG_OCCUPATION_OPTION)
    }
    
    func getOccupationOption()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_OCCUPATION_OPTION) != nil{
            return userdefault.value(forKey: KEY_CONFIG_OCCUPATION_OPTION) as! [String]
        }
        
        return []
    }
    
    // religion
    
    func setReligionID(religionid:[Int]){
        userdefault.set(religionid, forKey: KEY_CONFIG_RELIGION_ID)
    }
    
    func getReligionID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_RELIGION_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_RELIGION_ID) as! [Int]
        }
        
        return []
    }
    
    
    func setReligion(religion:[String]){
        userdefault.set(religion, forKey: KEY_CONFIG_RELIGION)
    }
    
    func getReligion()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_RELIGION) != nil{
            return userdefault.value(forKey: KEY_CONFIG_RELIGION) as! [String]
        }
        
        return []
    }
    
    // training
    
    func setTrainingID(trainingid:[Int]){
        userdefault.set(trainingid, forKey: KEY_CONFIG_TRAINING_ID)
    }
    
    func getTrainingID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_TRAINING_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_TRAINING_ID) as! [Int]
        }
        
        return []
    }
    
    func setTraining(training:[String]){
        userdefault.set(training, forKey: KEY_CONFIG_TRAINING)
    }
    
    func getTraining()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_TRAINING) != nil{
            return userdefault.value(forKey: KEY_CONFIG_TRAINING) as! [String]
        }
        
        return []
    }
    
    
    
    
    /* Province */
    
    // GeoID
    
    func setGeoID(geoid:[Int]){
        userdefault.set(geoid, forKey: KEY_CONFIG_PROVINCE_GEO_ID)
    }
    
    func getGeoID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_PROVINCE_GEO_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_PROVINCE_GEO_ID) as! [Int]
        }
        
        return []
    }
    
    
    // provinceID
    
    func setProvinceID(proid:[Int]){
        userdefault.set(proid, forKey: KEY_CONFIG_PROVINCE_ID)
    }
    
    func getProvinceID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_PROVINCE_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_PROVINCE_ID) as! [Int]
        }
        
        return []
    }
    
    // provinceCode
    
    func setProvinceCode(procode:[Int]){
        userdefault.set(procode, forKey: KEY_CONFIG_PROVINCE_CODE)
    }
    
    func getProvinceCode()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_PROVINCE_CODE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_PROVINCE_CODE) as! [Int]
        }
        
        return []
    }
    
    // provinceName
    
    func setProvinceName(proname:[String]){
        userdefault.set(proname, forKey: KEY_CONFIG_PROVINCE_NAME)
    }
    
    func getProvinceName()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_PROVINCE_NAME) != nil{
            return userdefault.value(forKey: KEY_CONFIG_PROVINCE_NAME) as! [String]
        }
        
        return []
    }
    
    
    /* Amphur */
    
    // GeoID
    
    func setAmphurGeoID(geoid:[Int]){
        userdefault.set(geoid, forKey: KEY_CONFIG_AMPHUR_GEO_ID)
    }
    func getAmphurGeoID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_AMPHUR_GEO_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_AMPHUR_GEO_ID) as! [Int]
        }
        
        return []
    }
    
    
    // AmphurID
    
    func setAmphurID(aumid:[Int]){
        userdefault.set(aumid, forKey: KEY_CONFIG_AMPHUR_ID)
    }
    
    func getAmphurID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_AMPHUR_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_AMPHUR_ID) as! [Int]
        }
        
        return []
    }
    
    // AmphurCode
    
    func setAmphurCode(aumcode:[Int]){
        userdefault.set(aumcode, forKey: KEY_CONFIG_AMPHUR_CODE)
    }
    
    func getAmphurCode()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_AMPHUR_CODE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_AMPHUR_CODE) as! [Int]
        }
        
        return []
    }
    
    // AmphurName
    
    func setAmphurName(aumname:[String]){
        userdefault.set(aumname, forKey: KEY_CONFIG_AMPHUR_NAME)
    }
    
    func getAmphurName()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_AMPHUR_NAME) != nil{
            return userdefault.value(forKey: KEY_CONFIG_AMPHUR_NAME) as! [String]
        }
        
        return []
    }
    
    
    /* District */
    
    // GeoID
    
    func setDistrictGeoID(geoid:[Int]){
        userdefault.set(geoid, forKey: KEY_CONFIG_DISTRICT_GEO_ID)
    }
    func getDistrictGeoID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_DISTRICT_GEO_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DISTRICT_GEO_ID) as! [Int]
        }
        
        return []
    }
    
    
    // DistrictID
    
    func setDistrictID(disid:[Int]){
        userdefault.set(disid, forKey: KEY_CONFIG_DISTRICT_ID)
    }
    
    func getDistrictID()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_DISTRICT_ID) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DISTRICT_ID) as! [Int]
        }
        
        return []
    }
    
    // DistrictCode
    
    func setDistrictCode(discode:[Int]){
        userdefault.set(discode, forKey: KEY_CONFIG_DISTRICT_CODE)
    }
    
    func getDistrictCode()->[Int]{
        
        if userdefault.value(forKey: KEY_CONFIG_DISTRICT_CODE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DISTRICT_CODE) as! [Int]
        }
        
        return []
    }
    
    // DistrictName
    
    func setDistrictName(disname:[String]){
        userdefault.set(disname, forKey: KEY_CONFIG_DISTRICT_NAME)
    }
    
    func getDistrictName()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_DISTRICT_NAME) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DISTRICT_NAME) as! [String]
        }
        
        return []
    }
    
    // DistrictZip
    
    func setDistrictZipCode(diszipcode:[String]){
        userdefault.set(diszipcode, forKey: KEY_CONFIG_DISTRICT_ZIPCODE)
    }
    
    func getDistrictZipCode()->[String]{
        
        if userdefault.value(forKey: KEY_CONFIG_DISTRICT_ZIPCODE) != nil{
            return userdefault.value(forKey: KEY_CONFIG_DISTRICT_ZIPCODE) as! [String]
        }
        
        return []
    }
    
}
