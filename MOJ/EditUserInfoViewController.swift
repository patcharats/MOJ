//
//  EditUserInfoViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class EditUserInfoViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let network = Network()
    let param = AccountParameter()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    let accountData = AccountData()
    
    let configData = ConfigData()
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


    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var firstnameTextfield: UITextField!
    @IBOutlet var lastnameTextfield: UITextField!
    @IBOutlet var emailnameTextfield: UITextField!
    
    @IBOutlet var addressTextfield: UITextField!
    
    @IBOutlet var addressProvinceTextfield: UITextField!
    @IBOutlet var addressAmphurTextfield: UITextField!
    @IBOutlet var addressTambonTextfield: UITextField!
    @IBOutlet var addressZipTextfield: UITextField!

    
    @IBOutlet var phoneTextfield: UITextField!
    var firstname:String? = ""
    var lastname:String? = ""
    var email:String? = ""
    var phone:String? = ""
    var address:String? = ""
    var address_tumbon:String? = ""
    var address_amphur:String? = ""
    var address_province:String? = ""
    var address_zip:String? = ""
    
    @IBOutlet var changePasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accountData.getAccountChannel() != "email" {
            changePasswordButton.isHidden = true
        }
        
        getConfigData()
        setPickerView()
        
        
        firstnameTextfield.text = accountData.getAccountFirstName()
        lastnameTextfield.text = accountData.getAccountLastName()
        emailnameTextfield.text = accountData.getAccountEmail()
        phoneTextfield.text = accountData.getAccountPhoneNo()
        
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
    }
    
    @IBAction func changeProfile(_ sender: Any) {

        firstname = firstnameTextfield.text!
        lastname = lastnameTextfield.text!
        email = emailnameTextfield.text!
        phone = phoneTextfield.text!
        
        address = addressTextfield.text!
        address_tumbon = String(SelectDistictID)
        address_amphur = String(SelectAmphurID)
        address_province = String(SelectProvinceID)
        address_zip = addressZipTextfield.text!
        
        if (firstname?.isEmpty)! || (lastname?.isEmpty)! || (email?.isEmpty)!{
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
            
        }
        else if(!(stringHelper.isValidEmail(email: email!))){
            alertView.alert(title: alertView.ALERT_WRONG_EMAIL_FORMAT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            getUpdateProfile()
        }
    }
    
    
    func getUpdateProfile(){
        param.username = email
        param.firstname = firstname
        param.lastname = lastname
        param.email = email
        param.phoneno = phone
        
        param.address = address
        param.address_tumbon = address_tumbon
        param.address_amphur = address_amphur
        param.address_province = address_province
        param.address_zip = address_zip
        
        network.post(name: network.API_UPDATE_PROFILE, param: param.getUpdateProfileParameter(), viewController: self, completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            if(Code == "00000"){
                self.alertView.alertWithAction(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                    (button : Bool) in
                    if button {
                        self.accountData.setAccountFirstName(accountFirstName: self.firstname!)
                        self.accountData.setAccountLastName(accountFirstName: self.lastname!)
                        self.accountData.setAccountPhoneNo(accountPhoneNo: self.phone!)
                        self.accountData.setAddress(address: self.addressTextfield.text!)
                        self.accountData.setAddressProvince(address: self.addressProvinceTextfield.text!)
                        self.accountData.setAddressAmphur(address: self.addressAmphurTextfield.text!)
                        self.accountData.setAddressTambon(address: self.addressTambonTextfield.text!)
                        self.accountData.setAddressZip(address: self.addressZipTextfield.text!)
                        
                        self.accountData.setAddressProvinceID(address: String(self.SelectProvinceID))
                        self.accountData.setAddressAmphurID(address: String(self.SelectAmphurID))
                        self.accountData.setAddressTambonID(address: String(self.SelectDistictID))
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                });
            }
            else{
                self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            }
            
            
            
        })
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        provinceID.insert(0, at: 0)
        provinceName.insert("", at: 0)
        
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        
    }
    func setPickerView(){
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        
        pickerView1.tag = PROVINCE_NAME
        pickerView2.tag = AMPHUR_NAME
        pickerView3.tag = DISTRICT_NAME
        
        addressProvinceTextfield.inputView = pickerView1
        addressAmphurTextfield.inputView = pickerView2
        addressTambonTextfield.inputView = pickerView3
        
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            switch pickerView.tag {
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
            
            
            //selectPrefixNameID = titleID[row]
        }
    
}

