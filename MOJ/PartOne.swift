//
//  PartOne.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PartOne:UITableViewController{
    
    @IBOutlet var registrationExpireTextField: UITextField!
    @IBOutlet var registrationDateTextField: UITextField!
    @IBOutlet var registrationNumberTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    let notificationName = Notification.Name("clearTextfieldRenew")
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
        NotificationCenter.default.addObserver(self, selector: #selector(PartOne.clearTextfield), name: notificationName, object: nil)

    }
    
    func clearTextfield(){
        registrationExpireTextField.text = ""
        registrationDateTextField.text = ""
        registrationNumberTextField.text = ""
        lastNameTextField.text = ""
        firstNameTextField.text = ""
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
