//
//  OccupationAndEducation.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OccupationAndEducation:UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    var socialWorkData = SocialWorkData()
    let configData = ConfigData()
    let network = Network()
    
    @IBOutlet var occupationTexField: UITextField!
    @IBOutlet var otherTexField: UITextField!
    @IBOutlet var governmentTexField: UITextField!
    @IBOutlet var positionTexField: UITextField!
    @IBOutlet var levelTexField: UITextField!
    
    @IBOutlet var houseNoTextField: UITextField!
    @IBOutlet var villageNoTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var roadTextField: UITextField!
    @IBOutlet var subDistrictTextField: UITextField!
    @IBOutlet var districtTextField: UITextField!
    @IBOutlet var provinceTextField: UITextField!
    @IBOutlet var postalCodeTextField: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var mobilePhoneTextField: UITextField!
    @IBOutlet var faxTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var educationTextField: UITextField!
    @IBOutlet var courseTextField: UITextField!
    @IBOutlet var fieldTextField: UITextField!
    @IBOutlet var facultyTextField: UITextField!
    @IBOutlet var universityTextField: UITextField!
    @IBOutlet var yearTextField: UITextField!
    
    var pickerView1:UIPickerView!
    var pickerView2:UIPickerView!
    var pickerView3:UIPickerView!
    var pickerView4:UIPickerView!
    var pickerView6:UIPickerView!
    var pickerView7:UIPickerView!
    var pickerView8:UIPickerView!
    
    
    let OCCUPATION_OPTION = 1
    let DEGREE = 2
    let MAJOR = 3
    let FIELD = 4
    
    let PROVINCE_NAME = 6
    let DISTRICT_NAME = 7
    let AMPHUR_NAME = 8

    var fieldStudyID:[[Int]] = []
    var fieldStudy:[[String]] = []
    
    var selectFieldStudyID:[Int] = []
    var selectFieldStudy:[String] = []
    
    var majorID:[Int] = []
    var major:[String] = []
    var degreeID:[Int] = []
    var degree:[String] = []
    var occupationOptionID:[Int] = []
    var occupationOption:[String] = []
    var trainingID:[Int] = []
    var training:[String] = []
    
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var amphurID:[Int] = []
    var amphurName:[String] = []
    
    var districtID:[Int] = []
    var districtName:[String] = []
    
    var zipcode:[String] = []
    
    var SelectFieldStudyIDS:Int = 0
    var SelectMajorID:Int = 0
    var SelectDegreeID:Int = 0
    var SelectOccupationOptionID:Int = 0
    var SelectOrgProvinceID:Int = 0
    var SelectOrgAmphurID:Int = 0
    var SelectOrgDistrictID:Int = 0
    
    let notificationDataForm2 = Notification.Name("DataForm2")
    let notificationName = Notification.Name("clearTextfieldCreate")
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(OccupationAndEducation.clearTextfield), name: notificationName, object: nil)
        
        let readOnly = socialWorkData.isReadOnly()
        
        if readOnly {
            socialWorkData.getSocialWorkData(json: socialWorkData.getData())
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)
            setEnabelTextfield(isEnable: false)
            setValueTextfield()
        }
        else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
            setEnabelTextfield(isEnable: true)
        }
        
        getConfigData()
        setPickerView()
        setTextFieldDelegate()
        
        
    }
    
    func setPickerView(){
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        pickerView4 = UIPickerView()
        pickerView6 = UIPickerView()
        pickerView7 = UIPickerView()
        pickerView8 = UIPickerView()
        
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView4.dataSource = self
        pickerView6.dataSource = self
        pickerView7.dataSource = self
        pickerView8.dataSource = self
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        pickerView6.delegate = self
        pickerView7.delegate = self
        pickerView8.delegate = self
        
        pickerView1.tag = OCCUPATION_OPTION
        pickerView2.tag = DEGREE
        pickerView3.tag = MAJOR
        pickerView4.tag = FIELD
        
        pickerView6.tag = PROVINCE_NAME
        pickerView7.tag = AMPHUR_NAME
        pickerView8.tag = DISTRICT_NAME
        
        provinceTextField.inputView = pickerView6
        districtTextField.inputView = pickerView7
        subDistrictTextField.inputView = pickerView8
        
        occupationTexField.inputView = pickerView1
        educationTextField.inputView = pickerView2
        courseTextField.inputView = pickerView3
        fieldTextField.inputView = pickerView4
    }
    
    func getConfigData(){
        
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        
        fieldStudyID = configData.getFieldStudyID()
        fieldStudy = configData.getFieldStudy()
        
        majorID = configData.getMajorID()
        major = configData.getMajor()
        degreeID = configData.getDegreeID()
        degree = configData.getDegree()
        occupationOptionID = configData.getOccupationOptionID()
        occupationOption = configData.getOccupationOption()
        
        trainingID = configData.getTrainingID()
        training = configData.getTraining()
        
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        let dataDict:[String: Any] = ["occupationTexField": occupationTexField.text!,
                                         "otherTexField": otherTexField.text!,
                                         "governmentTexField": governmentTexField.text!,
                                         "positionTexField": positionTexField.text!,
                                         "levelTexField": levelTexField.text!,
                                         "houseNoTextField": houseNoTextField.text!,
                                         "villageNoTextField": villageNoTextField.text!,
                                         "streetTextField": streetTextField.text!,
                                         "roadTextField": roadTextField.text!,
                                         "subDistrictTextField": subDistrictTextField.text!,
                                         "districtTextField": districtTextField.text!,
                                         "provinceTextField": provinceTextField.text!,
                                         "postalCodeTextField": postalCodeTextField.text!,
                                         "phoneTextField": phoneTextField.text!,
                                         "mobilePhoneTextField": mobilePhoneTextField.text!,
                                         "faxTextField": faxTextField.text!,
                                         "emailTextField": emailTextField.text!,
                                         "educationTextField": educationTextField.text!,
                                         "courseTextField": courseTextField.text!,
                                         "fieldTextField": fieldTextField.text!,
                                         "facultyTextField": facultyTextField.text!,
                                         "universityTextField": universityTextField.text!,
                                         "yearTextField": yearTextField.text!,
                                         "SelectFieldStudyIDS": SelectFieldStudyIDS,
                                         "SelectMajorID": SelectMajorID,
                                         "SelectDegreeID": SelectDegreeID,
                                         "SelectOccupationOptionID": SelectOccupationOptionID,
                                         "SelectOrgProvinceID": SelectOrgProvinceID,
                                         "SelectOrgAmphurID": SelectOrgAmphurID,
                                         "SelectOrgDistrictID": SelectOrgDistrictID
        ]
        
        NotificationCenter.default.post(name: notificationDataForm2, object: nil, userInfo: dataDict)
        
        
        
        return true
    }
    func setTextFieldDelegate(){
        occupationTexField.delegate = self
        otherTexField.delegate = self
        governmentTexField.delegate = self
        positionTexField.delegate = self
        levelTexField.delegate = self
        houseNoTextField.delegate = self
        villageNoTextField.delegate = self
        streetTextField.delegate = self
        roadTextField.delegate = self
        subDistrictTextField.delegate = self
        districtTextField.delegate = self
        provinceTextField.delegate = self
        postalCodeTextField.delegate = self
        phoneTextField.delegate = self
        mobilePhoneTextField.delegate = self
        faxTextField.delegate = self
        emailTextField.delegate = self
        educationTextField.delegate = self
        courseTextField.delegate = self
        fieldTextField.delegate = self
        facultyTextField.delegate = self
        universityTextField.delegate = self
        yearTextField.delegate = self
    }
    
    func setValueTextfield(){
        occupationTexField.text = socialWorkData.occupation
        otherTexField.text = socialWorkData.occother
        governmentTexField.text = socialWorkData.occorgname
        positionTexField.text = socialWorkData.occposition
        levelTexField.text = socialWorkData.occlevel
        houseNoTextField.text = socialWorkData.addrorgno
        villageNoTextField.text = socialWorkData.addrorgmoo
        streetTextField.text = socialWorkData.addrorgsoi
        roadTextField.text = socialWorkData.addrorroad
        subDistrictTextField.text = socialWorkData.addrortumbon
        districtTextField.text = socialWorkData.addroramphur
        provinceTextField.text = socialWorkData.addrorprovince
        postalCodeTextField.text = socialWorkData.addrorzip
        phoneTextField.text = socialWorkData.orgadphone
        mobilePhoneTextField.text = socialWorkData.orgadmobile
        faxTextField.text = socialWorkData.orgadfax
        emailTextField.text = socialWorkData.orgadmobile
        educationTextField.text = socialWorkData.degree
        courseTextField.text = socialWorkData.major
        fieldTextField.text = socialWorkData.requesttype
        facultyTextField.text = socialWorkData.study
        universityTextField.text = socialWorkData.institution
        yearTextField.text = socialWorkData.graduateyear
    }
    func clearTextfield(){
        occupationTexField.text = ""
        otherTexField.text = ""
        governmentTexField.text = ""
        positionTexField.text = ""
        levelTexField.text = ""
        houseNoTextField.text = ""
        villageNoTextField.text = ""
        streetTextField.text = ""
        roadTextField.text = ""
        subDistrictTextField.text = ""
        districtTextField.text = ""
        provinceTextField.text = ""
        postalCodeTextField.text = ""
        phoneTextField.text = ""
        mobilePhoneTextField.text = ""
        faxTextField.text = ""
        emailTextField.text = ""
        educationTextField.text = ""
        courseTextField.text = ""
        fieldTextField.text = ""
        facultyTextField.text = ""
        universityTextField.text = ""
        yearTextField.text = ""
    }
    
    func setEnabelTextfield(isEnable:Bool){
        occupationTexField.isEnabled = isEnable
        otherTexField.isEnabled = isEnable
        governmentTexField.isEnabled = isEnable
        positionTexField.isEnabled = isEnable
        levelTexField.isEnabled = isEnable
        houseNoTextField.isEnabled = isEnable
        villageNoTextField.isEnabled = isEnable
        streetTextField.isEnabled = isEnable
        roadTextField.isEnabled = isEnable
        subDistrictTextField.isEnabled = isEnable
        districtTextField.isEnabled = isEnable
        provinceTextField.isEnabled = isEnable
        postalCodeTextField.isEnabled = isEnable
        phoneTextField.isEnabled = isEnable
        mobilePhoneTextField.isEnabled = isEnable
        faxTextField.isEnabled = isEnable
        emailTextField.isEnabled = isEnable
        educationTextField.isEnabled = isEnable
        courseTextField.isEnabled = isEnable
        fieldTextField.isEnabled = isEnable
        facultyTextField.isEnabled = isEnable
        universityTextField.isEnabled = isEnable
        yearTextField.isEnabled = isEnable
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
    
        switch pickerView.tag {
        case OCCUPATION_OPTION:
            return occupationOption.count
        case DEGREE:
            return degree.count
        case MAJOR:
            return major.count
        case FIELD:
            return selectFieldStudy.count
        case PROVINCE_NAME:
            return provinceName.count
        case DISTRICT_NAME:
            return districtName.count
        case AMPHUR_NAME:
            return amphurName.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case OCCUPATION_OPTION:
            return occupationOption[row]
        case DEGREE:
            return degree[row]
        case MAJOR:
            return major[row]
        case FIELD:
            return selectFieldStudy[row]
        case PROVINCE_NAME:
            return provinceName[row]
        case DISTRICT_NAME:
            return districtName[row]
        case AMPHUR_NAME:
            return amphurName[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case OCCUPATION_OPTION:
            occupationTexField.text = occupationOption[row]
            SelectOccupationOptionID = occupationOptionID[row]
            
        case DEGREE:
            educationTextField.text = degree[row]
            SelectDegreeID = degreeID[row]
        case MAJOR:
            courseTextField.text = major[row]
            
            selectFieldStudyID = fieldStudyID[row]
            selectFieldStudy = fieldStudy[row]
            fieldTextField.text = ""
            SelectMajorID = majorID[row]
            
        case FIELD:
            fieldTextField.text = selectFieldStudy[row]
            SelectFieldStudyIDS = selectFieldStudyID[row]
            
        case PROVINCE_NAME:
            provinceTextField.text = provinceName[row]
            getAmphur(provinceID: provinceID[row])
            SelectOrgProvinceID = provinceID[row]
            
            
        case AMPHUR_NAME:
            districtTextField.text = amphurName[row]
            getTambon(amphurID: amphurID[row])
            SelectOrgAmphurID = amphurID[row]
            
        case DISTRICT_NAME:
            subDistrictTextField.text = districtName[row]
            postalCodeTextField.text = zipcode[row]
            SelectOrgDistrictID = districtID[row]
        default:
            print("fail")
        }
        
    }
    
    
    func getAmphur(provinceID:Int){
        let param = String(provinceID)
        self.network.get(name: self.network.API_CONFIG_AMPHUR, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigAmphur(json: json)
            self.amphurID = self.configData.getAmphurID()
            self.amphurName = self.configData.getAmphurName()
        })
    }
    
    func getTambon(amphurID:Int){
        let param = String(amphurID)
        self.network.get(name: self.network.API_CONFIG_DISTRICT, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigDistrict(json: json)
            self.districtID = self.configData.getDistrictID()
            self.districtName = self.configData.getDistrictName()
            self.zipcode = self.configData.getDistrictZipCode()
        })
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0 // your number of cell here
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
