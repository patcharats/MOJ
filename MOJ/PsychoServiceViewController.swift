//
//  PsychoServiceViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class PsychoServiceViewController: UIViewController {
    let design = Design()
    let alertView = AlertView()
    let network = Network()
    let accountData = AccountData()
    let DOCUMENT_COMPLETE = "เอกสารครบแล้ว"
    let DOCUMENT_NOT_COMPLETE = "เอกสารไม่ครบ"
    
    let TYPE_NOT_LOGIN = 0
    let TYPE_COMPLETE = 0001
    let TYPE_NOT_COMPLETE = 0002
    let TYPE_EXPIRE = 0003
    let TYPE_45_EXPIRE = 0004
    let TYPE_NOT_FOUND = 0005
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var idCardView: UIView!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var resultView: UIView!
    @IBOutlet var renewButton: UIButton!
    @IBOutlet var centerButton: UIButton!
    
    @IBOutlet var createNewButton: UIButton!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var expireLabel: UILabel!
    @IBOutlet var foundView: UIView!
    @IBOutlet var notfoundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        setupDesign()
        
        let account = AccountData()
        if account.isLogin() {
            setupView(type: TYPE_NOT_FOUND)
            addButton.isEnabled = true
            addButton.image = UIImage(named: "ic_add")
        }
        else{
            setupView(type: TYPE_NOT_LOGIN)
            addButton.isEnabled = false
            addButton.image = UIImage(named: "")
            
            alertView.alertWithAction(title:"", message: self.alertView.ALERT_LOGIN, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                (button : Bool) in
                if button {
                    self.alertView.setMainViewController()
                }
            });
        }
        
        var accountID = accountData.getAccountID()

        
        network.get(name: network.API_SOCIAL_WORK_REQUEST, param:accountID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
        })
        
        
    }
    
    
    
    func setupView(type:Int){
        switch type {
        case TYPE_NOT_LOGIN:
            foundView.isHidden = true
            notfoundView.isHidden = true
            
            break
        case TYPE_NOT_FOUND:
            foundView.isHidden = true
            notfoundView.isHidden = false
            
            break
        case TYPE_45_EXPIRE:
            expireLabel.isHidden = false
            centerButton.isHidden = false
            renewButton.isHidden = true
            resultView.isHidden = true
            foundView.isHidden = false
            notfoundView.isHidden = true
            
            break
        case TYPE_EXPIRE:
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = false
            resultView.isHidden = true
            foundView.isHidden = false
            notfoundView.isHidden = false
            
            break
        case TYPE_COMPLETE:
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = true
            resultView.isHidden = false
            foundView.isHidden = false
            notfoundView.isHidden = false
            
            statusLabel.text = DOCUMENT_COMPLETE
            // statusLabel color = green
            // resultView = 40
            
            break
        case TYPE_NOT_COMPLETE:
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = true
            resultView.isHidden = false
            foundView.isHidden = false
            notfoundView.isHidden = false
            
            statusLabel.text = DOCUMENT_NOT_COMPLETE
            // statusLabel color = red
            // resultView = 152
            break
        default:
            return
        }
    }
    
    func setupDesign(){
        
        design.roundView(view: createNewButton, radius: 5)
        design.roundView(view: renewButton, radius: 5)
        design.roundView(view: centerButton, radius: 5)
        design.roundView(view: statusLabel, radius: 5)
        design.roundView(view: resultView, radius: 5)
        design.roundView(view: idCardView, radius: 5)
        resultTextView.font = UIFont(name: "Quark-Bold", size: 15)
    }
    
    func setupMenuButton() {
        if revealViewController() != nil {
            let percent = self.view.frame.size.width - ((self.view.frame.size.width * 30)/100)
            revealViewController().rearViewRevealWidth = percent
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

