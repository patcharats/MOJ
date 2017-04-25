//
//  LoginViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    let SW_REVEAL_VIEW_CONTROLLER = "SWRevealViewController"
    let FORGET_PASSWORD_VIEW_CONTROLLER = "ForgetPasswordViewController"
    let REGISTER_VIEW_CONTROLLER = "RegisterViewController"
    var stringHelper = StringHelper()
    var network = Network()
    var facebookdata = FacebookData()
    var accountData = AccountData()
    var param = AccountParameter()
    var alertView = AlertView()
    
    var dict : [String : AnyObject]!
    var token:String? = ""
    var email:String? = ""
    var password:String? = ""
    var channel:String? = ""
    var facebook_id:String? = ""
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        accountData.setLogin(isLogin: false)
        setupNavigation()
    }
    
    func setupNavigation(){
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.token = FBSDKAccessToken.current().tokenString
                        self.getFBUserData()
                        //fbLoginManager.logOut()
                    }
                }
            }
        }
    }

    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    self.facebookdata.getFacebookData(json: result!)
//                    self.email = self.facebookdata.facebookEmail
//                    self.facebook_id = self.facebookdata.facebookID
                    self.channel = "facebook"
                    self.getLogin()
                }
            })
        }
    }
    
    func getLogin(){
        param.username = email
        param.password = stringHelper.getAesString(plainText: password!)
        param.channal = channel
        param.facebook_token = token
        network.post(name: network.API_LOGIN, param: param.getLoginParameter(), completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            
            if(Code == "00000"){
                self.accountData.getAccountData(json: JSON)
                self.setMainViewController()
            }
            else{
                self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            }
            
            
        })
    }
    
    @IBAction func loginAction(_ sender: Any) {
        email = emailTextfield.text!
        password = passwordTextfield.text!
        channel = "email"
        if (email?.isEmpty)! || (password?.isEmpty)! {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            getLogin()
            
        }
    }
    
    
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        performSegue(withIdentifier: FORGET_PASSWORD_VIEW_CONTROLLER, sender: self)
    }
    @IBAction func registerAction(_ sender: Any) {
        performSegue(withIdentifier: REGISTER_VIEW_CONTROLLER, sender: self)
    }

    
    @IBAction func skipAction(_ sender: Any) {
        setMainViewController()
    }
    
    func setMainViewController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let swRevealViewController = mainStoryBoard.instantiateViewController(withIdentifier: SW_REVEAL_VIEW_CONTROLLER)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = swRevealViewController
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FORGET_PASSWORD_VIEW_CONTROLLER {
            
        }
        else if segue.identifier == REGISTER_VIEW_CONTROLLER {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
