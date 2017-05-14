//
//  ProsonalInformation.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class ProsonalInformation:UITableViewController{
    
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
