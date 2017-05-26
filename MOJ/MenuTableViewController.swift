//
//  MenuHambergerView.swift
//  socialtv
//
//  Created by Patcharat on 9/8/2559 BE.
//  Copyright © 2559 Patcharat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class MenuTableViewController: UITableViewController {
    let design = Design()
    let network = Network()
    let account = AccountData()
    let alertView = AlertView()
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var psychoLabel: UILabel!
    let notificationName = Notification.Name("UpdateProfile")
    override func viewDidLoad() {
        super.viewDidLoad()
        design.roundView(view: loginButton, radius: 5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MenuTableViewController.UpdateProfile), name: notificationName, object: nil)
        UpdateProfile()
    }

    func UpdateProfile(){
        if account.isLogin() {
            logoImageView.image = UIImage(named: "image_profile")
            nameLabel.text = account.getAccountFirstName()+" "+account.getAccountLastName()
            editProfile.isHidden = false
            loginButton.setTitle("ออกจากระบบ", for: UIControlState.normal)
            
        }
        else{
            logoImageView.image = UIImage(named: "logo_login")
            nameLabel.text = "MOJ Application"
            editProfile.isHidden = true
            loginButton.setTitle("เข้าสู่ระบบ", for: UIControlState.normal)
        }
    }



    @IBAction func logout(_ sender: Any) {
        
        if self.account.isLogin() {
            alertView.alertWith2Action(title:"", message: self.alertView.ALERT_LOGOUT, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                (button : Bool) in
                
                if button {
                    
                    if let bundle = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundle)
                    }
                    
                    self.alertView.setMainViewController()
                    
                }
            });
        }
        else{
            self.alertView.setMainViewController()
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
