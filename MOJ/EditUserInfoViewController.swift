//
//  EditUserInfoViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class EditUserInfoViewController: UIViewController {
    let network = Network()
    let param = AccountParameter()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    let accountData = AccountData()

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var firstnameTextfield: UITextField!
    @IBOutlet var lastnameTextfield: UITextField!
    @IBOutlet var emailnameTextfield: UITextField!
    
    @IBOutlet var phoneTextfield: UITextField!
    var firstname:String? = ""
    var lastname:String? = ""
    var email:String? = ""
    var phone:String? = ""
    
    @IBOutlet var changePasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accountData.getAccountChannel() != "email" {
            changePasswordButton.isHidden = true
        }
        
        
        firstnameTextfield.text = accountData.getAccountFirstName()
        lastnameTextfield.text = accountData.getAccountLastName()
        emailnameTextfield.text = accountData.getAccountEmail()
    }
    
    @IBAction func changeProfile(_ sender: Any) {

        firstname = firstnameTextfield.text!
        lastname = lastnameTextfield.text!
        email = emailnameTextfield.text!
        phone = phoneTextfield.text!
        
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
        
        network.post(name: network.API_UPDATE_PROFILE, param: param.getUpdateProfileParameter(), viewController: self, completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            if(Code == "00000"){
                self.alertView.alertWithAction(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                    (button : Bool) in
                    if button {
                        self.accountData.setAccountFirstName(accountFirstName: self.firstname!)
                        self.accountData.setAccountLastName(accountFirstName: self.lastname!)
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
    
    
}

