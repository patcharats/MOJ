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
    
    var socialWorkData = SocialWorkData()
    
    let REQUEST_DOCUMENT = "ยื่นคำขอ"
    let DOCUMENT_COMPLETE_WAIT_APPROVE = "เอกสารครบรอการอนุมัติ"
    let DOCUMENT_APPROVE = "อนุมัติใบคำขอ"
    
    @IBOutlet var notfoundLabel: UILabel!
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
    @IBOutlet var requestViewTop: NSLayoutConstraint!
    @IBOutlet var requestViewHeight: NSLayoutConstraint!
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
    let KEY_SOCIAL_REQUEST_TEXT_MARK = "txtremark"
    
    let KEY_SOCIAL_LICENSE = "license"
    let KEY_SOCIAL_LICENSE_CARD_ID = "cardid"
    let KEY_SOCIAL_LICENSE_CARD_NO = "cardno"
    let KEY_SOCIAL_LICENSE_ISSUE_DATE = "issuedate"
    let KEY_SOCIAL_LICENSE_EXPIRE_DATE = "expiredate"
    let KEY_SOCIAL_LICENSE_TITLE = "title"
    let KEY_SOCIAL_LICENSE_FIRSTNAME = "firstname"
    let KEY_SOCIAL_LICENSE_LASTNAME = "lastname"
    let KEY_SOCIAL_LICENSE_CARD_STATUS = "cardstatus"
    
    let LICENSE_DETAIL = "LicenseDetail"
    var acctid:String = ""
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
    var request_txtremark:String = ""

    
    var license_cardid:String = ""
    var license_cardno:String = ""
    var license_issuedate:String = ""
    var license_expiredate:String = ""
    var license_title:String = ""
    var license_firstname:String = ""
    var license_lastname:String = ""
    var license_cardstatus:String = ""
    var accountID:String = ""
    @IBOutlet var resultHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        setupDesign()
        searchTextField.delegate = self
        let account = AccountData()
        if account.isLogin() {
            addButton.isEnabled = true
            addButton.image = UIImage(named: "ic_add")
            
            accountID = accountData.getAccountID()
            acctid = accountData.getAccountID()
            
             accountID = "1"
             acctid = "1"
            
            //getLicenseDetail(accountIDs: accountID, touchDetail: false)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector (self.licenseDatail(sender:)))
            idCardView.addGestureRecognizer(gesture)
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


        
    }
    
    func getLicenseDetail(accountIDs:String,touchDetail:Bool){
        network.getWithToken(name: network.API_SOCIAL_WORK_REQUEST, param:accountIDs, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            if Code == "10000"{
                
                self.notfoundLabel.text = Message
                self.setupView(type: self.TYPE_NOT_FOUND)
            }
            else{
                let swiftyJson = JSON(json)
                self.socialWorkData.setData(json: swiftyJson)
                self.socialWorkData.setReadOnly(isReadOnly: false)
                
                if touchDetail {
                    self.performSegue(withIdentifier: self.LICENSE_DETAIL, sender: nil)
                    self.socialWorkData.setReadOnly(isReadOnly: true)
                }
                
            }
        })
    }
    @IBAction func addButton(_ sender: Any) {
        self.socialWorkData.setReadOnly(isReadOnly: false)
        self.performSegue(withIdentifier: self.LICENSE_DETAIL, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LICENSE_DETAIL{
            let controller = segue.destination as! PsychoServiceCreateNew
        }
    }
    
    func licenseDatail(sender:UITapGestureRecognizer){
        if !acctid.isEmpty || acctid != accountID {
            getLicenseDetail(accountIDs: acctid, touchDetail: true)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getAccountData(json:Any){
        let jsonSwifty = JSON(json)
        
        acctid = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_ACCOUNT_ID].stringValue
        request_reqid = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_ID].stringValue
        request_reqno = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_NO].stringValue
        request_reqtype = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_TYPE].stringValue
        request_reqdate = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_DATE].stringValue
        request_reqstatus = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_STATUS].stringValue
        request_title = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_TITLE].stringValue
        request_firstname = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_FIRSTNAME].stringValue
        request_lastname = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_LASTNAME].stringValue
        request_checkdoc =  jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_CHECK_DOC].stringValue
        request_confirmdata = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_CONFIRM_DATA].stringValue
        request_provlatedoc = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_PROVE_LAST_DOC].stringValue
        request_txtremark = jsonSwifty[KEY_SOCIAL_DATA][KEY_SOCIAL_REQUEST][KEY_SOCIAL_REQUEST_TEXT_MARK].stringValue
        
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
        
        requireNoLabel.text = "คำร้องเลขที่ "+request_reqno
        statusLabel.text = " "+request_reqstatus+" "
        statusLabel.sizeToFit()
        
        let height = request_txtremark.height(withConstrainedWidth: self.view.frame.size.width - 30, font: UIFont(name: "Quark-Bold", size: 15)!)
        
        resultTextView.text = request_txtremark
        requestViewHeight.constant = height + 60

        if license_issuedate.isEmpty {
            idCardView.isHidden = true
            requestViewTop.constant = 16
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = true
        }
        else{
            idCardView.isHidden = false
            requestViewTop.constant = 163
            if (stringHelper.timeRemainingString(date: license_issuedate) > 45) {
                setupView(type: TYPE_EXPIRE)
            }
            else{
                setupView(type: TYPE_45_EXPIRE)
            }
        }
    
            
        if request_reqstatus == REQUEST_DOCUMENT || request_reqstatus == DOCUMENT_COMPLETE_WAIT_APPROVE || request_reqstatus == DOCUMENT_APPROVE
        {
            setupView(type: TYPE_COMPLETE)
        }
        else{
            setupView(type: TYPE_NOT_COMPLETE)
        }
        
        

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
            notfoundLabel.isHidden = true
            createNewButton.isHidden = true
            
            break
        case TYPE_NOT_FOUND:
            foundView.isHidden = true
            notfoundView.isHidden = false
            notfoundLabel.isHidden = false
            createNewButton.isHidden = false
            
            break
        case TYPE_45_EXPIRE:
            expireLabel.isHidden = false
            centerButton.isHidden = false
            renewButton.isHidden = true
            
            break
        case TYPE_EXPIRE:
            expireLabel.isHidden = true
            centerButton.isHidden = true
            renewButton.isHidden = false

            
            break
        case TYPE_COMPLETE:
            resultView.isHidden = false
            foundView.isHidden = false
            notfoundView.isHidden = false
            design.setLabelColorGreen(label: statusLabel)
            
            break
        case TYPE_NOT_COMPLETE:
            resultView.isHidden = false
            foundView.isHidden = false
            notfoundView.isHidden = false
            design.setLabelColorRed(label: statusLabel)
            
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

