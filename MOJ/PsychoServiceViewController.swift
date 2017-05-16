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

class PsychoServiceViewController: UIViewController,UITextFieldDelegate {
    let design = Design()
    let alertView = AlertView()
    let network = Network()
    let accountData = AccountData()
    let param = PsychoParameter()
    let stringHelper = StringHelper()
    let REQUEST_DOCUMENT = "ยื่นคำขอ"
    let DOCUMENT_COMPLETE_WAIT_APPROVE = "เอกสารครบรอการอนุมัติ"
    let DOCUMENT_APPROVE = "อนุมัติใบคำขอ"
    
    let TYPE_NOT_LOGIN = 0
    let TYPE_COMPLETE = 1
    let TYPE_NOT_COMPLETE = 2
    let TYPE_EXPIRE = 3
    let TYPE_45_EXPIRE = 4
    let TYPE_NOT_FOUND = 5
    
    @IBOutlet var requireNoLabel: UILabel!
    
    @IBOutlet var licenseExpireLabel: UILabel!
    @IBOutlet var licenseNameLabel: UILabel!
    @IBOutlet var licenseNumberLabel: UILabel!
    
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
    
    @IBOutlet var searchTextField: UITextField!
    
    let KEY_SOCIAL_DATA = "data"
    let KEY_SOCIAL_ACCOUNT_ID = "acctid"
    
    let KEY_SOCIAL_REQUEST = "request"
    let KEY_SOCIAL_REQUEST_ID = "reqid"
    let KEY_SOCIAL_REQUEST_NO = "reqno"
    let KEY_SOCIAL_REQUEST_TYPE = "reqtype"
    let KEY_SOCIAL_REQUEST_DATE = "reqdate"
    let KEY_SOCIAL_REQUEST_STATUS = "reqstatus"
    let KEY_SOCIAL_REQUEST_TITLE = "title"
    let KEY_SOCIAL_REQUEST_FIRSTNAME = "firstname"
    let KEY_SOCIAL_REQUEST_LASTNAME = "lastname"
    let KEY_SOCIAL_REQUEST_CHECK_DOC = "checkdoc"
    let KEY_SOCIAL_REQUEST_CONFIRM_DATA = "confirmdata"
    let KEY_SOCIAL_REQUEST_PROVE_LAST_DOC = "provlatedoc"

    let KEY_SOCIAL_LICENSE = "license"
    let KEY_SOCIAL_LICENSE_CARD_ID = "cardid"
    let KEY_SOCIAL_LICENSE_CARD_NO = "cardno"
    let KEY_SOCIAL_LICENSE_ISSUE_DATE = "issuedate"
    let KEY_SOCIAL_LICENSE_EXPIRE_DATE = "expiredate"
    let KEY_SOCIAL_LICENSE_TITLE = "title"
    let KEY_SOCIAL_LICENSE_FIRSTNAME = "firstname"
    let KEY_SOCIAL_LICENSE_LASTNAME = "lastname"
    let KEY_SOCIAL_LICENSE_CARD_STATUS = "cardstatus"
    
    var request_reqid:String = ""
    var request_reqno:String = ""
    var request_reqtype:String = ""
    var request_reqdate:String = ""
    var request_reqstatus:String = ""
    var request_title:String = ""
    var request_firstname:String = ""
    var request_lastname:String = ""
    var request_checkdoc:String = ""
    var request_confirmdata:String = ""
    var request_provlatedoc:String = ""

    
    var license_cardid:String = ""
    var license_cardno:String = ""
    var license_issuedate:String = ""
    var license_expiredate:String = ""
    var license_title:String = ""
    var license_firstname:String = ""
    var license_lastname:String = ""
    var license_cardstatus:String = ""
    
    @IBOutlet var resultHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        setupDesign()
        searchTextField.delegate = self
        let account = AccountData()
        if account.isLogin() {
            setupView(type: TYPE_EXPIRE)
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
        network.getWithToken(name: network.API_SOCIAL_WORK_REQUEST, param:accountID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            //self.getAccountData(json: json)
        })
        
        
    }
    
    func getAccountData(json:Any){
        let jsonSwifty = JSON(json)
        
        
        let request_reqid_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_ID].stringValue})
        let request_reqtype_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_TYPE].stringValue})
        let request_reqdate_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_DATE].stringValue})
        let request_reqstatus_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_STATUS].stringValue})
        let request_title_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_TITLE].stringValue})
        let request_firstname_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_FIRSTNAME].stringValue})
        let request_lastname_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_LASTNAME].stringValue})
        let request_checkdoc_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_CHECK_DOC].stringValue})
        let request_confirmdata_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_CONFIRM_DATA].stringValue})
        let request_provlatedoc_arr = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST].arrayValue.map({$0[KEY_SOCIAL_REQUEST_PROVE_LAST_DOC].stringValue})
        
        request_reqid = request_reqid_arr[0]
        request_reqtype = request_reqtype_arr[0]
        request_reqdate = request_reqdate_arr[0]
        request_reqstatus = request_reqstatus_arr[0]
        request_title = request_title_arr[0]
        request_firstname = request_firstname_arr[0]
        request_lastname = request_lastname_arr[0]
        request_checkdoc =  request_checkdoc_arr[0]
        request_confirmdata = request_confirmdata_arr[0]
        request_provlatedoc = request_provlatedoc_arr[0]
        
        license_cardid = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_CARD_ID].stringValue
        license_cardno = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_CARD_NO].stringValue
        license_issuedate = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_ISSUE_DATE].stringValue
        license_expiredate = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_EXPIRE_DATE].stringValue
        license_title = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_TITLE].stringValue
        license_firstname = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_FIRSTNAME].stringValue
        license_lastname = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_LASTNAME].stringValue
        license_cardstatus = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_LICENSE][KEY_SOCIAL_LICENSE_CARD_STATUS].stringValue
        

        licenseNameLabel.text = license_firstname+" "+license_lastname
        licenseNumberLabel.text = "ทะเบียนเลขที่ "+license_cardno
        licenseExpireLabel.text = "บัตรหมดอายุ " + stringHelper.getDatefromString(dateString: license_expiredate)
        
        requireNoLabel.text = "คำร้องเลขที่ "
        statusLabel.text = request_reqstatus
        
        /*
         
        if (stringHelper.timeRemainingString(issuedate: license_issuedate) > 45) {
            setupView(type: TYPE_45_EXPIRE)
        }
        else if (stringHelper.timeRemainingString(issuedate: license_issuedate) < 45){
            setupView(type: TYPE_EXPIRE)
        }
        else
            */
        if request_reqstatus == REQUEST_DOCUMENT || request_reqstatus == DOCUMENT_COMPLETE_WAIT_APPROVE || request_reqstatus == DOCUMENT_APPROVE
        {
            setupView(type: TYPE_COMPLETE)
        }
        else{
            setupView(type: TYPE_NOT_COMPLETE)
        }
        
        print(license_expiredate)
        print(license_issuedate)
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField(text: textField.text!)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func searchTextField(text:String){
        param.search_key = text
        network.post(name: network.API_SOCIAL_WORK_SEARCH, param:param.getSearchParameter(), viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            if Code == "10000"{
                self.expireLabel.text = Message
                self.setupView(type: self.TYPE_NOT_FOUND)
            }
            else{
                self.getAccountData(json: json)
            }
            
        })
    }
    
    
    func setupView(type:Int){
        switch type {
        case TYPE_NOT_LOGIN:
            foundView.isHidden = true
            notfoundView.isHidden = true
            expireLabel.isHidden = true
            centerButton.isHidden = true
            
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
            // statusLabel color = green
            resultHeight.constant = 50
            
            break
        case TYPE_NOT_COMPLETE:
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = true
            resultView.isHidden = false
            foundView.isHidden = false
            notfoundView.isHidden = false
            // statusLabel color = red
            
            resultHeight.constant = 155
            
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

