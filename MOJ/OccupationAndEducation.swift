//
//  OccupationAndEducation.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OccupationAndEducation:UITableViewController{
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
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
