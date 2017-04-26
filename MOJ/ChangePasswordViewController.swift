//
//  ChangePasswordViewController.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var rePasswordTextfield: UITextField!
    @IBOutlet var newPasswordTextfield: UITextField!
    @IBOutlet var oldPasswordTextfield: UITextField!
    @IBOutlet var menuButton: UIBarButtonItem!
    let alertView = AlertView()
    let param = AccountParameter()
    let network = Network()
    let stringHelper = StringHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func chagePassword(_ sender: Any) {
        let oldPassword = oldPasswordTextfield.text
        let newPassword = newPasswordTextfield.text
        let rePassword = rePasswordTextfield.text
        
        if (oldPassword?.characters.count)! < 6 || (oldPassword?.characters.count)! > 12 {
            alertView.alert(title: alertView.ALERT_WRONG_OLD_PASSWORD, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if (newPassword?.characters.count)! < 6 || (newPassword?.characters.count)! > 12 {
            alertView.alert(title: alertView.ALERT_WRONG_NEW_PASSWORD, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else if newPassword != rePassword{
            alertView.alert(title: alertView.ALERT_WRONG_RE_PASSWORD, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            param.old_password = stringHelper.getAesString(plainText: oldPassword!)
            param.new_password = stringHelper.getAesString(plainText: newPassword!)
            param.confirm_new_password = stringHelper.getAesString(plainText: rePassword!)
            
            network.post(name: network.API_CHANGE_PASSWORD, param: param.getForgetPasswordParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    self.alertView.alertWithAction(title:"", message: self.alertView.ALERT_CHANGE_PASSWORD_SUCCESS, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                        (button : Bool) in
                        if button {
                            self.back()
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
        back()
    }
    
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

