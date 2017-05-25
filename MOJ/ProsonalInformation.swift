//
//  ProsonalInformation.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class ProsonalInformation:UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var socialWorkData = SocialWorkData()
    let network = Network()
    let configData = ConfigData()
    
    let CARD_TYPE = 1
    let PREFIX_NAME = 2
    let MARITAL_STATUS = 3
    let NATIONALITY = 4
    let RELIGION = 5
    let PROVINCE_NAME = 6
    let DISTRICT_NAME = 7
    let AMPHUR_NAME = 8
    
    let PROVINCE_NAME2 = 62
    let DISTRICT_NAME2 = 72
    let AMPHUR_NAME2 = 82
    
    
    let DATE_EXPIRE = 11
    let ID_DATE  = 12
    let BIRTH_DATE = 13
    
    @IBOutlet var IDTypeTextField: UITextField!
    @IBOutlet var IDNumberTextField: UITextField!
    @IBOutlet var IDExpireTextField: UITextField!
    @IBOutlet var IDDateTextField: UITextField!
    @IBOutlet var IDByTextField: UITextField!
    
    @IBOutlet var titleNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdateTextField: UITextField!
    @IBOutlet var maritalStatusTextField: UITextField!
    @IBOutlet var religionTextField: UITextField!
    @IBOutlet var nationalityTextField: UITextField!
    
    @IBOutlet var houseNoTextField: UITextField!
    @IBOutlet var villageNoTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var roadTextField: UITextField!
    @IBOutlet var subDistrictTextField: UITextField!
    @IBOutlet var districtTextField: UITextField!
    @IBOutlet var provinceTextField: UITextField!
    @IBOutlet var postalCodeTextField: UITextField!
    
    @IBOutlet var houseNoTextField2: UITextField!
    @IBOutlet var villageNoTextField2: UITextField!
    @IBOutlet var streetTextField2: UITextField!
    @IBOutlet var roadTextField2: UITextField!
    @IBOutlet var subDistrictTextField2: UITextField!
    @IBOutlet var districtTextField2: UITextField!
    @IBOutlet var provinceTextField2: UITextField!
    @IBOutlet var postalCodeTextField2: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var mobilePhoneTextField: UITextField!
    @IBOutlet var faxTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    var pickerView1:UIPickerView!
    var pickerView2:UIPickerView!
    var pickerView3:UIPickerView!
    //var pickerView4:UIPickerView!
    //var pickerView5:UIPickerView!
    var pickerView6:UIPickerView!
    var pickerView7:UIPickerView!
    var pickerView8:UIPickerView!
    var pickerView9:UIPickerView!
    var pickerView10:UIPickerView!
    var pickerView11:UIPickerView!
    
    var nationalityID:[Int] = []
    var nationalityName:[String] = []
    
    var maritalStatusID:[Int] = []
    var maritalStatusName:[String] = []
    
    var cardID:[Int] = []
    var cardType:[String] = []
    
    var titleID:[Int] = []
    var titleName:[String] = []
    
    var religionID:[Int] = []
    var religionName:[String] = []
    
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var amphurID:[Int] = []
    var amphurName:[String] = []
    
    var districtID:[Int] = []
    var districtName:[String] = []
    
    var zipcode:[String] = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        socialWorkData.getSocialWorkData(json: socialWorkData.getData())
        let readOnly = socialWorkData.isReadOnly()
        
        if readOnly {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)
            setEnabelTextfield(isEnable: false)
            setValueTextfield()
        }
        else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
            setEnabelTextfield(isEnable: true)
        }
        
        getConfigDate()
        setPickerDate()
        setPickerView()
        
    }
    
    func setValueTextfield(){
        
        IDTypeTextField.text = socialWorkData.requesttype
        IDNumberTextField.text = socialWorkData.requestid
        IDExpireTextField.text = socialWorkData.requestdate
        IDDateTextField.text = socialWorkData.requestdate
        IDByTextField.text = socialWorkData.requestid
        
        titleNameTextField.text = socialWorkData.prename
        firstNameTextField.text = socialWorkData.firstname
        lastNameTextField.text = socialWorkData.lastname
        birthdateTextField.text = socialWorkData.birthdate
        maritalStatusTextField.text = socialWorkData.maritalstatus
        religionTextField.text = socialWorkData.religion
        nationalityTextField.text = socialWorkData.nationality
        
        houseNoTextField.text = socialWorkData.addr1no
        villageNoTextField.text = socialWorkData.addr1moo
        streetTextField.text = socialWorkData.addr1soi
        roadTextField.text = socialWorkData.addr1road
        subDistrictTextField.text = socialWorkData.addr1tumbon
        districtTextField.text = socialWorkData.addr1amphur
        provinceTextField.text = socialWorkData.addr1province
        postalCodeTextField.text = socialWorkData.addr1zip
        
        houseNoTextField2.text = socialWorkData.addr2no
        villageNoTextField2.text = socialWorkData.addr2moo
        streetTextField2.text = socialWorkData.addr2soi
        roadTextField2.text = socialWorkData.addr2road
        subDistrictTextField2.text = socialWorkData.addr2tumbon
        districtTextField2.text = socialWorkData.addr2amphur
        provinceTextField2.text = socialWorkData.addr2province
        postalCodeTextField2.text = socialWorkData.addr2zip
        
        phoneTextField.text = socialWorkData.addr2telephn
        mobilePhoneTextField.text = socialWorkData.addr2mobile
        faxTextField.text = socialWorkData.addr2fax
        emailTextField.text = socialWorkData.addr2email
    }
    
    func getConfigDate(){
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        
        
        cardID = configData.getCardID()
        cardType = configData.getCard()
        
        
        maritalStatusID = configData.getMaritalStatusID()
        maritalStatusName = configData.getMaritalStatus()
        
        religionID = configData.getReligionID()
        religionName = configData.getReligion()
        
        
        titleName = configData.getNamePrefix()
        titleID = configData.getNamePrefixID()
    }
    
    func setPickerDate(){
        let datePickerView1:UIDatePicker = UIDatePicker()
        datePickerView1.datePickerMode = UIDatePickerMode.date
        datePickerView1.calendar = Calendar(identifier: .buddhist)
        datePickerView1.locale = Locale(identifier: "th")
        datePickerView1.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        IDExpireTextField.inputView = datePickerView1
        datePickerView1.tag = DATE_EXPIRE
        
        let datePickerView2:UIDatePicker = UIDatePicker()
        datePickerView2.datePickerMode = UIDatePickerMode.date
        datePickerView2.calendar = Calendar(identifier: .buddhist)
        datePickerView2.locale = Locale(identifier: "th")
        datePickerView2.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        IDDateTextField.inputView = datePickerView2
        datePickerView2.tag = ID_DATE
        
        
        let datePickerView3:UIDatePicker = UIDatePicker()
        datePickerView3.datePickerMode = UIDatePickerMode.date
        datePickerView3.calendar = Calendar(identifier: .buddhist)
        datePickerView3.locale = Locale(identifier: "th")
        datePickerView3.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        birthdateTextField.inputView = datePickerView3
        datePickerView3.tag = BIRTH_DATE
    }
    
    func setPickerView(){
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        //pickerView4 = UIPickerView()
        //pickerView5 = UIPickerView()
        pickerView6 = UIPickerView()
        pickerView7 = UIPickerView()
        pickerView8 = UIPickerView()
        pickerView9 = UIPickerView()
        pickerView10 = UIPickerView()
        pickerView11 = UIPickerView()
        
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        //pickerView4.dataSource = self
        //pickerView5.dataSource = self
        pickerView6.dataSource = self
        pickerView7.dataSource = self
        pickerView8.dataSource = self
        pickerView9.dataSource = self
        pickerView10.dataSource = self
        pickerView11.dataSource = self
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        //pickerView4.delegate = self
        //pickerView5.delegate = self
        pickerView6.delegate = self
        pickerView7.delegate = self
        pickerView8.delegate = self
        pickerView9.delegate = self
        pickerView10.delegate = self
        pickerView11.delegate = self
        
        pickerView1.tag = CARD_TYPE
        pickerView2.tag = PREFIX_NAME
        pickerView3.tag = MARITAL_STATUS
        //pickerView4.tag = RELIGION
        //pickerView5.tag = NATIONALITY
        pickerView6.tag = PROVINCE_NAME
        pickerView7.tag = AMPHUR_NAME
        pickerView8.tag = DISTRICT_NAME
        pickerView9.tag = PROVINCE_NAME2
        pickerView10.tag = AMPHUR_NAME2
        pickerView11.tag = DISTRICT_NAME2
        
        IDTypeTextField.inputView = pickerView1
        titleNameTextField.inputView = pickerView2
        maritalStatusTextField.inputView = pickerView3
        //religionTextField.inputView = pickerView4
        //nationalityTextField.inputView = pickerView5
        provinceTextField.inputView = pickerView6
        districtTextField.inputView = pickerView7
        subDistrictTextField.inputView = pickerView8
        provinceTextField2.inputView = pickerView9
        districtTextField2.inputView = pickerView10
        subDistrictTextField2.inputView = pickerView11
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"th")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        if sender.tag == 1 {
            IDDateTextField.text = dateFormatter.string(from: sender.date)
        }
        else if sender.tag == 2 {
            IDExpireTextField.text = dateFormatter.string(from: sender.date)
        }
        else{
            birthdateTextField.text = dateFormatter.string(from: sender.date)
        }
        
    }
    
    func setEnabelTextfield(isEnable:Bool){
        
            IDTypeTextField.isEnabled = isEnable
            IDNumberTextField.isEnabled = isEnable
            IDExpireTextField.isEnabled = isEnable
            IDDateTextField.isEnabled = isEnable
            IDByTextField.isEnabled = isEnable
            
            titleNameTextField.isEnabled = isEnable
            firstNameTextField.isEnabled = isEnable
            lastNameTextField.isEnabled = isEnable
            birthdateTextField.isEnabled = isEnable
            maritalStatusTextField.isEnabled = isEnable
            religionTextField.isEnabled = isEnable
            nationalityTextField.isEnabled = isEnable
            
            houseNoTextField.isEnabled = isEnable
            villageNoTextField.isEnabled = isEnable
            streetTextField.isEnabled = isEnable
            roadTextField.isEnabled = isEnable
            subDistrictTextField.isEnabled = isEnable
            districtTextField.isEnabled = isEnable
            provinceTextField.isEnabled = isEnable
            postalCodeTextField.isEnabled = isEnable
            
            houseNoTextField2.isEnabled = isEnable
            villageNoTextField2.isEnabled = isEnable
            streetTextField2.isEnabled = isEnable
            roadTextField2.isEnabled = isEnable
            subDistrictTextField2.isEnabled = isEnable
            districtTextField2.isEnabled = isEnable
            provinceTextField2.isEnabled = isEnable
            postalCodeTextField2.isEnabled = isEnable
            
            phoneTextField.isEnabled = isEnable
            mobilePhoneTextField.isEnabled = isEnable
            faxTextField.isEnabled = isEnable
            emailTextField.isEnabled = isEnable
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        /*
        provinceName
        amphurName
        districtName
        cardType
        maritalStatusName
        religionName
        titleName
 */
        
        switch pickerView.tag {
        case CARD_TYPE:
            return cardType.count
        case PREFIX_NAME:
            return titleName.count
        case MARITAL_STATUS:
            return maritalStatusName.count
        /* case NATIONALITY:
            return
        case RELIGION:
            return religionName.count
             */
        case PROVINCE_NAME:
            return provinceName.count
        case DISTRICT_NAME:
            return districtName.count
        case AMPHUR_NAME:
            return amphurName.count
        case PROVINCE_NAME2:
            return provinceName.count
        case DISTRICT_NAME2:
            return districtName.count
        case AMPHUR_NAME2:
            return amphurName.count
        default:
            return 0
        }
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case CARD_TYPE:
            return cardType[row]
        case PREFIX_NAME:
            return titleName[row]
        case MARITAL_STATUS:
            return maritalStatusName[row]
            /* case NATIONALITY:
             return
        case RELIGION:
            return religionName[row]
 */
        case PROVINCE_NAME:
            return provinceName[row]
        case DISTRICT_NAME:
            return districtName[row]
        case AMPHUR_NAME:
            return amphurName[row]
        case PROVINCE_NAME2:
            return provinceName[row]
        case DISTRICT_NAME2:
            return districtName[row]
        case AMPHUR_NAME2:
            return amphurName[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        

        switch pickerView.tag {
        case CARD_TYPE:
            IDTypeTextField.text = cardType[row]
        case PREFIX_NAME:
            titleNameTextField.text = titleName[row]
        case MARITAL_STATUS:
            maritalStatusTextField.text = maritalStatusName[row]
            /* case NATIONALITY:
             return
        case RELIGION:
            religionTextField.text = religionName[row]
 */
        case PROVINCE_NAME:
            provinceTextField.text = provinceName[row]
            getAmphur(provinceID: provinceID[row])
            
        case AMPHUR_NAME:
            districtTextField.text = amphurName[row]
            getTambon(amphurID: amphurID[row])
            
        case DISTRICT_NAME:
            subDistrictTextField.text = districtName[row]
            postalCodeTextField.text = zipcode[row]
            
        case PROVINCE_NAME2:
            provinceTextField2.text = provinceName[row]
            getAmphur(provinceID: provinceID[row])
            
        case AMPHUR_NAME2:
            districtTextField2.text = amphurName[row]
            getTambon(amphurID: amphurID[row])
            
        case DISTRICT_NAME2:
            subDistrictTextField2.text = districtName[row]
            postalCodeTextField2.text = zipcode[row]
            
        default:
            print("fail")
        }
        
        
        //selectPrefixNameID = titleID[row]
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
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
