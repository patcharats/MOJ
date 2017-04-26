//
//  RegisterViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    let network = Network()
    let param = AccountParameter()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    @IBOutlet var firstnameTextfield: UITextField!
    @IBOutlet var lastnameTextfield: UITextField!
    @IBOutlet var emailnameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var phoneTextfield: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    
    var firstname:String? = ""
    var lastname:String? = ""
    var email:String? = ""
    var phone:String? = ""
    var password:String? = ""
    var repassword:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func confirmButton(_ sender: Any) {
        
        firstname = firstnameTextfield.text!
        lastname = lastnameTextfield.text!
        email = emailnameTextfield.text!
        password = passwordTextfield.text!
        repassword = confirmPasswordTextfield.text!
        phone = phoneTextfield.text!
        
        if (firstname?.isEmpty)! || (lastname?.isEmpty)! || (phone?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)! || (repassword?.isEmpty)! {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
            
        }
        else if(!(stringHelper.isValidEmail(email: email!))){
            alertView.alert(title: alertView.ALERT_WRONG_EMAIL_FORMAT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if ((password?.characters.count)! < 6 || (password?.characters.count)! > 12){
            alertView.alert(title: alertView.ALERT_PASSWORD_6_12_CHAR, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if (password != repassword){
            alertView.alert(title: alertView.ALERT_WRONG_RE_PASSWORD, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            getRegister()
        }
    }
    
    func getRegister(){
        
        param.username = email
        param.firstname = firstname
        param.lastname = lastname
        param.email = email
        param.phoneno = phone
        param.password = stringHelper.getAesString(plainText: password!)
        param.channal = "email"
        network.post(name: network.API_REGISTER, param: param.getRegisterParameter(), viewController: self, completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            if(Code == "00000"){
                self.alertView.alertWithAction(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                    (button : Bool) in
                    if button {
                        self.backToLogin()
                    }
                });
            }
            else{
                self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            }
            
            
            
        })
    }


    @IBAction func backButton(_ sender: Any) {
        backToLogin()
    }
    
    func backToLogin(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
