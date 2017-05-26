//
//  OccupationAndEducation.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OccupationAndEducation:UITableViewController{
    var socialWorkData = SocialWorkData()
    let configData = ConfigData()
    
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
        
        /*
        
        configData.getFieldStudyID()
        configData.getFieldStudy()
        
        configData.getMajorID()
        configData.getMajor()
        configData.getDegreeID()
        configData.getDegree()
        configData.getOccupationOptionID()
        configData.getOccupationOption()
        
        configData.getTrainingID()
        configData.getTraining()
 */
        
        
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
