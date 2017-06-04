//
//  PartOne.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PartOne:UITableViewController,UITextFieldDelegate{
    
    @IBOutlet var registrationExpireTextField: UITextField!
    @IBOutlet var registrationDateTextField: UITextField!
    @IBOutlet var registrationNumberTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    let notificationName = Notification.Name("clearTextfieldRenew")
    let notificationDataFormRenew1 = Notification.Name("DataFormRenew1")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
        NotificationCenter.default.addObserver(self, selector: #selector(PartOne.clearTextfield), name: notificationName, object: nil)

        setTextFieldDelegate()
    }
    
    func clearTextfield(){
        registrationExpireTextField.text = ""
        registrationDateTextField.text = ""
        registrationNumberTextField.text = ""
        lastNameTextField.text = ""
        firstNameTextField.text = ""
    }
    
    func setTextFieldDelegate(){
        registrationExpireTextField.delegate = self
        registrationDateTextField.delegate = self
        registrationNumberTextField.delegate = self
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let dataDict:[String: Any] = ["registrationExpireTextField": registrationExpireTextField.text!,
                                      "registrationDateTextField": registrationDateTextField.text!,
                                      "registrationNumberTextField": registrationNumberTextField.text!,
                                      "registrationlastNameTextField": lastNameTextField.text!,
                                      "registrationfirstNameTextField": firstNameTextField.text!
                                      ]
        
        NotificationCenter.default.post(name: notificationDataFormRenew1, object: nil, userInfo: dataDict)
        
        return true
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
