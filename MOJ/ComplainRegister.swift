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


    @IBOutlet var idBackNumberTextfiled: UITextField!
    @IBOutlet var idNumberTextfield: UITextField!
    @IBOutlet var birthdateTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var titleNameTextfield: UITextField!
    
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
        
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        titleNameTextfield.inputView = pickerView

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleNameTextfield.text = titleName[row]
        selectPrefixNameID = titleID[row]
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
        else if (idbacknumber.characters.count != 12){
            alertView.alert(title: alertView.ALERT_WRONG_BACK_ID_NUMBER, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            param.prename = titles
            param.birthdate = birthdate
            param.pid = idnumber
            param.laser = idbacknumber
            
            network.post(name: network.API_VERIFY_ID, param: param.getVerifyIDParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    self.performSegue(withIdentifier: self.COMPLAIN_CREATE, sender: self)
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

    
}
