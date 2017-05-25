//
//  OtherDetail.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OtherDetail:UITableViewController{
    var socialWorkData = SocialWorkData()
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
