//
//  ForgetPasswordViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class ForgetPasswordViewController: UIViewController {
    let param = AccountParameter()
    let network = Network()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    @IBOutlet var emailTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func confirmButton(_ sender: Any) {
        let email = emailTextfield.text
        
        if(!(stringHelper.isValidEmail(email: email!))){
            alertView.alert(title: alertView.ALERT_WRONG_EMAIL_FORMAT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            param.email = email
            network.post(name: network.API_FORGOT_PASSWORD, param: param.getForgetPasswordParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    self.alertView.alertWithAction(title:"", message: self.alertView.ALERT_FORGOT_PASSWORD, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
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
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        backToLogin()
    }

    func backToLogin(){
        _ = navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
