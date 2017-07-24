//
//  PartThree.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PartThree:UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    let configData = ConfigData()
    let network = Network()
    
    @IBOutlet var occupationTexField: UITextField!
    @IBOutlet var otherTexField: UITextField!
    @IBOutlet var governmentTexField: UITextField!
    @IBOutlet var positionTexField: UITextField!
    @IBOutlet var levelTexField: UITextField!
    
    @IBOutlet var govNumberTextfield: UITextField!
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
    
    @IBOutlet var province1TextField: UITextField!
    @IBOutlet var province2TextField: UITextField!
    @IBOutlet var province3TextField: UITextField!
    
    var pickerView1:UIPickerView!
    var pickerView6:UIPickerView!
    var pickerView7:UIPickerView!
    var pickerView8:UIPickerView!
    
    let OCCUPATION_OPTION = 1
    let PROVINCE_NAME = 6
    let DISTRICT_NAME = 7
    let AMPHUR_NAME = 8
    
    
    var occupationOptionID:[Int] = []
    var occupationOption:[String] = []
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var amphurID:[Int] = []
    var amphurName:[String] = []
    
    var districtID:[Int] = []
    var districtName:[String] = []
    
    var zipcode:[String] = []
    
    var SelectOccupationOptionID:Int = 0
    var SelectOrgProvinceID:Int = 0
    var SelectOrgAmphurID:Int = 0
    var SelectOrgDistrictID:Int = 0
    
    var SelectProvince1:Int = 0
    var SelectProvince2:Int = 0
    var SelectProvince3:Int = 0
    
    let notificationName = Notification.Name("clearTextfieldRenew")
    
    let notificationDataFormRenew3 = Notification.Name("DataFormRenew3")
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PartThree.clearTextfield), name: notificationName, object: nil)
        setTextFieldDelegate()
        
        
        getConfigData()
        setPickerView()
    }
    
    func setPickerView(){
        pickerView1 = UIPickerView()
        
        pickerView6 = UIPickerView()
        pickerView7 = UIPickerView()
        pickerView8 = UIPickerView()
        
        pickerView1.dataSource = self
        
        pickerView6.dataSource = self
        pickerView7.dataSource = self
        pickerView8.dataSource = self
        
        pickerView1.delegate = self
        
        pickerView6.delegate = self
        pickerView7.delegate = self
        pickerView8.delegate = self
        
        pickerView1.tag = OCCUPATION_OPTION
        
        
        pickerView6.tag = PROVINCE_NAME
        pickerView7.tag = AMPHUR_NAME
        pickerView8.tag = DISTRICT_NAME
        
        provinceTextField.inputView = pickerView6
        districtTextField.inputView = pickerView7
        subDistrictTextField.inputView = pickerView8
        
        occupationTexField.inputView = pickerView1
        
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
        province1TextField.delegate = self
        province2TextField.delegate = self
        province3TextField.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let dataDict:[String: Any] = ["occupationTexField": occupationTexField.text!,
                                      "otherTexField": otherTexField.text!,
                                      "governmentTexField": governmentTexField.text!,
                                      "govNumberTextfield":govNumberTextfield.text!,
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
                                      "province1TextField" : province1TextField.text!,
                                      "province2TextField" : province2TextField.text!,
                                      "province3TextField" : province3TextField.text!,
                                      "SelectProvince1" : SelectProvince1,
                                      "SelectProvince2" : SelectProvince2,
                                      "SelectProvince3" : SelectProvince3
            
        ]
        
        NotificationCenter.default.post(name: notificationDataFormRenew3, object: nil, userInfo: dataDict)
        
        
        
        return true
    }
    
    func clearTextfield(){
        occupationTexField.text = ""
        otherTexField.text = ""
        governmentTexField.text = ""
        govNumberTextfield.text = ""
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
        province1TextField.text = ""
        province2TextField.text = ""
        province3TextField.text = ""
    }
    
    
    
    func getConfigData(){
        
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        occupationOptionID = configData.getOccupationOptionID()
        occupationOption = configData.getOccupationOption()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        switch pickerView.tag {
        case OCCUPATION_OPTION:
            return occupationOption.count
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
    
 func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == occupationTexField {
            occupationTexField.text = occupationOption[0]
            SelectOccupationOptionID = occupationOptionID[0]
            
        }
        else if textField == provinceTextField {
            provinceTextField.text = provinceName[0]
            getAmphur(provinceID: provinceID[0])
            SelectOrgProvinceID = provinceID[0]
        }
            
        else if textField == districtTextField {
            if amphurName.count != 0{
                districtTextField.text = amphurName[0]
                getTambon(amphurID: amphurID[0])
                SelectOrgAmphurID = amphurID[0]
            }
            
        }
            
        else if textField == subDistrictTextField {
            if districtName.count != 0{
                subDistrictTextField.text = districtName[0]
                postalCodeTextField.text = zipcode[0]
                SelectOrgDistrictID = districtID[0]
            }
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
