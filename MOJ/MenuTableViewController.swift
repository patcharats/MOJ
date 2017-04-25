//
//  MenuHambergerView.swift
//  socialtv
//
//  Created by Patcharat on 9/8/2559 BE.
//  Copyright © 2559 Patcharat. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController: UITableViewController {
    let LOGIN_VIEW_CONTROLLER = "NavigationLogin"

    let design = Design()
    let account = AccountData()
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var psychoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        design.roundView(view: loginButton, radius: 5)
        
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
        if account.isLogin() {
            if let bundle = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundle)
            }
        }

        setMainViewController()
    }
    
    func setMainViewController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let swRevealViewController = mainStoryBoard.instantiateViewController(withIdentifier: LOGIN_VIEW_CONTROLLER)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = swRevealViewController
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
