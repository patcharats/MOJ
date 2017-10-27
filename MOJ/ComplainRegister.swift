//
//  ComplainRegister.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class ComplainRegister: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    let TITLE_NAME = 0
    let PROVINCE_NAME = 1
    let AMPHUR_NAME = 2
    let DISTRICT_NAME = 3
    
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var amphurID:[Int] = []
    var amphurName:[String] = []
    
    var districtID:[Int] = []
    var districtName:[String] = []
    
    var zipcode:[String] = []
    
    var pickerView1:UIPickerView!
    var pickerView2:UIPickerView!
    var pickerView3:UIPickerView!
    
    var SelectProvinceID:Int = 0
    var SelectAmphurID:Int = 0
    var SelectDistictID:Int = 0
    var address:String? = ""
    var address_tumbon:String? = ""
    var address_amphur:String? = ""
    var address_province:String? = ""
    var address_zip:String? = ""
    
    @IBOutlet var idBackNumberTextfiled: UITextField!
    @IBOutlet var idNumberTextfield: UITextField!
    @IBOutlet var birthdateTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var titleNameTextfield: UITextField!
    
    
    @IBOutlet var addressTextfield: UITextField!
    
    @IBOutlet var addressProvinceTextfield: UITextField!
    @IBOutlet var addressAmphurTextfield: UITextField!
    @IBOutlet var addressTambonTextfield: UITextField!
    @IBOutlet var addressZipTextfield: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    var pickerView:UIPickerView!
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    let configData = ConfigData()
    var titleName:[String] = []
    var titleID:[Int] = []
    var selectPrefixNameID = 0
    
    var param = ComplaintParameter()

    
    var titles = ""
    var firstname = ""
    var lastname = ""
    var birthdate = ""
    var idnumber = ""
    var idbacknumber = ""
    
    let COMPLAIN_CREATE = "ComplainCreate"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextfield.text = accountData.getAccountFirstName()
        lastNameTextfield.text = accountData.getAccountLastName()
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.calendar = Calendar(identifier: .buddhist)
        datePickerView.locale = Locale(identifier: "th")
        birthdateTextfield.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ComplainRegister.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        titleName = configData.getNamePrefix()
        titleID = configData.getNamePrefixID()
        
        titleID.insert(0, at: 0)
        titleName.insert("", at: 0)
        
        address = accountData.getAddress()
        address_province = accountData.getAddressProvince()
        address_amphur = accountData.getAddressAmphur()
        address_tumbon = accountData.getAddressTambon()
        address_zip = accountData.getAddressZip()
        SelectProvinceID = Int(accountData.getAddressProvinceID())!
        SelectAmphurID = Int(accountData.getAddressAmphurID())!
        SelectDistictID = Int(accountData.getAddressTambonID())!
        
        
        addressTextfield.text = address
        addressProvinceTextfield.text = address_province
        addressAmphurTextfield.text = address_amphur
        addressTambonTextfield.text = address_tumbon
        addressZipTextfield.text = address_zip
        
        getConfigData()
        setPickerView()

    }


    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"th")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        birthdateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func NextButton(_ sender: Any) {
        titles = titleNameTextfield.text!
        firstname = firstNameTextfield.text!
        lastname = lastNameTextfield.text!
        birthdate = birthdateTextfield.text!
        idnumber = idNumberTextfield.text!
        idbacknumber = idBackNumberTextfiled.text!
        
        if (titles.isEmpty) || (firstname.isEmpty) || (lastname.isEmpty) || (birthdate.isEmpty) || (idnumber.isEmpty) || (idbacknumber.isEmpty) {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if (!stringHelper.validatePersionId(stringPersionId:idnumber)) {
            alertView.alert(title: alertView.ALERT_WRONG_FRONT_ID_NUMBER, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if (idbacknumber.characters.count == 0){
            alertView.alert(title: alertView.ALERT_WRONG_BACK_ID_NUMBER, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            param.prename = titles
            param.birthdate = birthdate
            param.pid = idnumber
            param.laser = idbacknumber
            
            param.address = address
            param.address_tumbon = address_tumbon
            param.address_amphur = address_amphur
            param.address_province = address_province
            param.address_zip = address_zip
            
            network.post(name: network.API_VERIFY_ID, param: param.getVerifyIDParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    self.performSegue(withIdentifier: self.COMPLAIN_CREATE, sender: self)
                    self.accountData.setComplaintStatus(hasComplaintStatus: true)
                }
                else{
                    self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                }
                
            })
        }

        
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    

    
    ///////// PICKER VIEW
    
    func getAmphur(provinceID:Int){
        let param = String(provinceID)
        self.network.get(name: self.network.API_CONFIG_AMPHUR, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigAmphur(json: json)
            self.amphurID = self.configData.getAmphurID()
            self.amphurName = self.configData.getAmphurName()
            
            self.amphurID.insert(0, at: 0)
            self.amphurName.insert("", at: 0)
            
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
            
            self.districtID.insert(0, at: 0)
            self.districtName.insert("", at: 0)
            self.zipcode.insert("", at: 0)
        })
    }
    
    func getConfigData(){
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        provinceID.insert(0, at: 0)
        provinceName.insert("", at: 0)
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        
    }
    func setPickerView(){
        pickerView = UIPickerView()
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        
        pickerView.dataSource = self
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        
        pickerView.delegate = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        
        pickerView.tag = TITLE_NAME
        pickerView1.tag = PROVINCE_NAME
        pickerView2.tag = AMPHUR_NAME
        pickerView3.tag = DISTRICT_NAME
        
        titleNameTextfield.inputView = pickerView
        addressProvinceTextfield.inputView = pickerView1
        addressAmphurTextfield.inputView = pickerView2
        addressTambonTextfield.inputView = pickerView3
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case TITLE_NAME:
            return titleName.count
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
        case TITLE_NAME:
            return titleName[row]
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
        case TITLE_NAME:
            titleNameTextfield.text = titleName[row]
            selectPrefixNameID = titleID[row]
        case PROVINCE_NAME:
            addressProvinceTextfield.text = provinceName[row]
            getAmphur(provinceID: provinceID[row])
            SelectProvinceID = provinceID[row]
            
        case AMPHUR_NAME:
            addressAmphurTextfield.text = amphurName[row]
            getTambon(amphurID: amphurID[row])
            SelectAmphurID = amphurID[row]
            
        case DISTRICT_NAME:
            addressTambonTextfield.text = districtName[row]
            addressZipTextfield.text = zipcode[row]
            SelectDistictID = districtID[row]
            
        default:
            print("fail")
        }
        
    }
    
    

    
}
