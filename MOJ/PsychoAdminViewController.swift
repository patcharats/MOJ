//
//  PsychoAdminViewController.swift
//  MOJ
//
//  Created by patcharat on 4/22/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class PsychoAdminViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let network = Network()
    let accountData = AccountData()
    let design = Design()
    let stringHelper = StringHelper()
    let param = PsychoParameter()
    let alertView = AlertView()
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var countRequestLabel: UILabel!
    
    let KEY_SOCIAL_DATA = "data"
    let KEY_SOCIAL_REQUEST = "requests"
    let KEY_SOCIAL_REASON = "reason"
    
    let KEY_SOCIAL_CONFIRM_DATA = "confirmdata"
    let KEY_SOCIAL_DOCUMENT_CHECK = "documentcheck"
    let KEY_SOCIAL_REQUEST_DATE = "requestdate"
    let KEY_SOCIAL_REQUEST_ID = "requestid"
    let KEY_SOCIAL_REQUEST_STATUS = "requeststatus"
    let KEY_SOCIAL_REQUEST_TYPE = "requesttype"
    
    var confirmdata:[String] = []
    var documentcheck:[String] = []
    var requestdate:[String] = []
    var requestid:[String] = []
    var requeststatus:[String] = []
    var requesttype:[String] = []
    
    var approve = ""
    var noApproveReason = ""
    var accountID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        
        accountID = accountData.getAccountID()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        getApprovallist()
    }

   
    func getApprovallist(){
        
        network.getWithToken(name: network.API_SOCIAL_WORK_APPROVE_LIST, param:accountID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            if Code == "00000"{
                let swiftyJson = JSON(json)
                
                self.confirmdata = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_CONFIRM_DATA].stringValue})
                self.documentcheck = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_DOCUMENT_CHECK].stringValue})
                self.requestdate = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_DATE].stringValue})
                self.requestid = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_ID].stringValue})
                self.requeststatus = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_STATUS].stringValue})
                self.requesttype = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_TYPE].stringValue})
                
                self.countRequestLabel.text = "มีคำขอ "+String(self.requestid.count)+" ฉบับ"
                
                self.tableView.reloadData()
                
                print("confirmdata :",self.confirmdata);
                print("documentcheck :",self.documentcheck);
                print("requestdate :",self.requestdate);
                print("requestid :",self.requestid);
                print("requeststatus :",self.requeststatus);
                print("requesttype :",self.requesttype);
            }
        })
    }
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestid.count
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! postAdminCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        design.roundView(view: cell.confirmButton, radius: 5)
        design.roundView(view: cell.notConfirmButton, radius: 5)
        
        cell.statusCodeLabel.text = requestid[indexPath.row]
        
        cell.typeLabel.text = requesttype[indexPath.row]
        cell.statusDocLabel.text = documentcheck[indexPath.row]
        cell.statusRequestLabel.text = requeststatus[indexPath.row]
        cell.statusConfirmLabel.text = confirmdata[indexPath.row]
       
        cell.dateLabel.text = stringHelper.getDatefromString(dateString: requestdate[indexPath.row])
        
        cell.confirmButton.tag = indexPath.row
        cell.confirmButton.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
        
        cell.notConfirmButton.tag = indexPath.row
        cell.notConfirmButton.addTarget(self, action: #selector(notConfirmButton), for: .touchUpInside)
        
        
        return cell
    }
    
    func confirmButton(sender: UIButton!) {
        self.approve = "y"
        let message = "คุณต้องการอนุมัติให้ "+String(requestid[sender.tag])
        
        self.alertView.alertWith2Action(title:"", message: message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
            (button : Bool) in
            if button {
                self.approve(requestID: self.requestid[sender.tag])
            }
        });
    }
    
    func notConfirmButton(sender: UIButton!) {
        self.approve = "n"
        
        let message = "คุณไม่อนุมัติให้ "+String(requestid[sender.tag])+" เนื่องจาก"
        let alert = UIAlertController(title: "", message:message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title:"ยกเลิก", style: .destructive, handler: { [weak alert] (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title:"ตกลง", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.noApproveReason = (textField?.text)!
            print("self.noApproveReason :",self.noApproveReason)
            self.approve(requestID: self.requestid[sender.tag])
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func approve(requestID:String){
        
        param.requestid = requestID
        param.approve = approve
        param.noapprvreason = noApproveReason
    
        
        network.post(name: network.API_SOCIAL_WORK_APPROVE+accountID, param:param.getApproveParameter(), viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.alertView.alert(title: "", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)

            if Code == "00000"{
                self.getApprovallist()
            }
            
        })
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


class postAdminCell: UITableViewCell {
    @IBOutlet var notConfirmButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var statusCodeLabel: UILabel!
    
    @IBOutlet var statusConfirmLabel: UILabel!
    @IBOutlet var statusDocLabel: UILabel!
    @IBOutlet var statusRequestLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
