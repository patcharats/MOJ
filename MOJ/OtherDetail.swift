//
//  OtherDetail.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OtherDetail:UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    var socialWorkData = SocialWorkData()
    var configData = ConfigData()
    
    @IBOutlet var trainingTextField: UITextField!
    @IBOutlet var trainingByTextField: UITextField!
    @IBOutlet var trainingDateTextField: UITextField!
    
    @IBOutlet var lastExperienceTextField: UITextField!
    @IBOutlet var experienceStartTextField: UITextField!
    @IBOutlet var experienceEndField: UITextField!
    @IBOutlet var detailExperienceTextField: UITextField!
    
    @IBOutlet var province1TextField: UITextField!
    @IBOutlet var province2TextField: UITextField!
    @IBOutlet var province3TextField: UITextField!
    let notificationDataForm3 = Notification.Name("DataForm3")
    let notificationName = Notification.Name("clearTextfieldCreate")
    var pickerView1:UIPickerView!
    var pickerView2:UIPickerView!
    var pickerView3:UIPickerView!
    var pickerView4:UIPickerView!
    
    let TRAINING = 1
    let PROVINCE1 = 2
    let PROVINCE2 = 3
    let PROVINCE3 = 4
    
    let TRAINING_DATE = 12
    let EXP_START_DATE = 13
    let EXP_END_DATE = 14
    
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var trainingID:[Int] = []
    var training:[String] = []
    
    var SelectTrainingID:Int = 0
    var SelectProvince1:Int = 0
    var SelectProvince2:Int = 0
    var SelectProvince3:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(OtherDetail.clearTextfield), name: notificationName, object: nil)
        
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
        setTextFieldDelegate()
        setPickerView()
        setPickerDate()
    }
    
    
    
    
    func getConfigData(){
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        
        trainingID = configData.getTrainingID()
        training = configData.getTraining()
        
    }
    func setPickerView(){
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        pickerView4 = UIPickerView()
        
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        pickerView4.dataSource = self
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView4.delegate = self
        
        pickerView1.tag = TRAINING
        pickerView2.tag = PROVINCE1
        pickerView3.tag = PROVINCE2
        pickerView4.tag = PROVINCE3
        
        trainingTextField.inputView = pickerView1
        province1TextField.inputView = pickerView2
        province2TextField.inputView = pickerView3
        province3TextField.inputView = pickerView4
    }
    
    func setPickerDate(){
        let datePickerView1:UIDatePicker = UIDatePicker()
        datePickerView1.datePickerMode = UIDatePickerMode.date
        datePickerView1.calendar = Calendar(identifier: .buddhist)
        datePickerView1.locale = Locale(identifier: "th")
        datePickerView1.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        trainingDateTextField.inputView = datePickerView1
        datePickerView1.tag = TRAINING_DATE
        
        let datePickerView2:UIDatePicker = UIDatePicker()
        datePickerView2.datePickerMode = UIDatePickerMode.date
        datePickerView2.calendar = Calendar(identifier: .buddhist)
        datePickerView2.locale = Locale(identifier: "th")
        datePickerView2.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        experienceStartTextField.inputView = datePickerView2
        datePickerView2.tag = EXP_START_DATE
        
        
        let datePickerView3:UIDatePicker = UIDatePicker()
        datePickerView3.datePickerMode = UIDatePickerMode.date
        datePickerView3.calendar = Calendar(identifier: .buddhist)
        datePickerView3.locale = Locale(identifier: "th")
        datePickerView3.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        experienceEndField.inputView = datePickerView3
        datePickerView3.tag = EXP_END_DATE
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"th")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        
        if sender.tag == TRAINING_DATE {
            trainingDateTextField.text = dateFormatter.string(from: sender.date)
        }
        else if sender.tag == EXP_START_DATE {
            experienceStartTextField.text = dateFormatter.string(from: sender.date)
        }
        else if sender.tag == EXP_END_DATE {
            experienceEndField.text = dateFormatter.string(from: sender.date)
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let dataDict:[String: Any] = ["trainingTextField": trainingTextField.text!,
                                         "trainingByTextField": trainingByTextField.text!,
                                         "trainingDateTextField": trainingDateTextField.text!,
                                         "lastExperienceTextField": lastExperienceTextField.text!,
                                         "experienceStartTextField": experienceStartTextField.text!,
                                         "experienceEndField": experienceEndField.text!,
                                         "detailExperienceTextField": detailExperienceTextField.text!,
                                         "province1TextField": province1TextField.text!,
                                         "province2TextField": province2TextField.text!,
                                         "province3TextField": province3TextField.text!,
                                         "SelectTrainingID" : SelectTrainingID,
                                         "SelectProvince1" : SelectProvince1,
                                         "SelectProvince2" : SelectProvince2,
                                         "SelectProvince3" : SelectProvince3
            
        ]
        
        NotificationCenter.default.post(name: notificationDataForm3, object: nil, userInfo: dataDict)
        
        
        
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        switch pickerView.tag {
        case TRAINING:
            return training.count
        case PROVINCE1:
            return provinceName.count
        case PROVINCE2:
            return provinceName.count
        case PROVINCE3:
            return provinceName.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case TRAINING:
            return training[row]
        case PROVINCE1:
            return provinceName[row]
        case PROVINCE2:
            return provinceName[row]
        case PROVINCE3:
            return provinceName[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case TRAINING:
            trainingTextField.text = training[row]
            SelectTrainingID = trainingID[row]
        case PROVINCE1:
            province1TextField.text = provinceName[row]
            SelectProvince1 = provinceID[row]
        case PROVINCE2:
            province2TextField.text = provinceName[row]
            SelectProvince2 = provinceID[row]
        case PROVINCE3:
            province3TextField.text = provinceName[row]
            SelectProvince3 = provinceID[row]
        default:
            print("fail")
        }
        
    }
    
    
    func setTextFieldDelegate(){
        trainingTextField.delegate = self
        trainingByTextField.delegate = self
        trainingDateTextField.delegate = self
        lastExperienceTextField.delegate = self
        experienceStartTextField.delegate = self
        experienceEndField.delegate = self
        detailExperienceTextField.delegate = self
        province1TextField.delegate = self
        province2TextField.delegate = self
        province3TextField.delegate = self
    }
    
    
    func clearTextfield(){
        trainingTextField.text = ""
        trainingByTextField.text = ""
        trainingDateTextField.text = ""
        lastExperienceTextField.text = ""
        experienceStartTextField.text = ""
        experienceEndField.text = ""
        detailExperienceTextField.text = ""
        province1TextField.text = ""
        province2TextField.text = ""
        province3TextField.text = ""
    }
    func setValueTextfield(){
        trainingTextField.text = socialWorkData.training
        trainingByTextField.text = socialWorkData.trainby
        trainingDateTextField.text = socialWorkData.traindate
        lastExperienceTextField.text = socialWorkData.lastworkorg
        experienceStartTextField.text = socialWorkData.lastorgstart
        experienceEndField.text = socialWorkData.lastorgend
        detailExperienceTextField.text = "??"
        province1TextField.text = socialWorkData.province1
        province2TextField.text = socialWorkData.province2
        province3TextField.text = socialWorkData.province3
    }
    func setEnabelTextfield(isEnable:Bool){
        trainingTextField.isEnabled = isEnable
        trainingByTextField.isEnabled = isEnable
        trainingDateTextField.isEnabled = isEnable
        lastExperienceTextField.isEnabled = isEnable
        experienceStartTextField.isEnabled = isEnable
        experienceEndField.isEnabled = isEnable
        detailExperienceTextField.isEnabled = isEnable
        province1TextField.isEnabled = isEnable
        province2TextField.isEnabled = isEnable
        province3TextField.isEnabled = isEnable
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
