//
//  PartThree.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PartThree:UITableViewController{
    
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
    
    @IBOutlet var province1TextField: UITextField!
    @IBOutlet var province2TextField: UITextField!
    @IBOutlet var province3TextField: UITextField!
    
    let notificationName = Notification.Name("clearTextfieldRenew")
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PartThree.clearTextfield), name: notificationName, object: nil)

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
        province1TextField.text = ""
        province2TextField.text = ""
        province3TextField.text = ""
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
