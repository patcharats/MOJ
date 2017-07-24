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
class PsychoAdminViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    let network = Network()
    let accountData = AccountData()
    let design = Design()
    let stringHelper = StringHelper()
    let param = PsychoParameter()
    let alertView = AlertView()
    
    
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var countRequestLabel: UILabel!
    var socialWorkData = SocialWorkData()
    let LICENSE_DETAIL = "LicenseDetail"
    
    let KEY_SOCIAL_DATA = "data"
    let KEY_SOCIAL_REQUEST = "requests"
    let KEY_SOCIAL_REASON = "reason"
    
    let KEY_SOCIAL_CONFIRM_DATA = "confirmdata"
    let KEY_SOCIAL_DOCUMENT_CHECK = "documentcheck"
    let KEY_SOCIAL_REQUEST_DATE = "requestdate"
    let KEY_SOCIAL_NAME = "endorsee"
    let KEY_SOCIAL_REQUEST_ID = "requestid"
    let KEY_SOCIAL_REQUEST_STATUS = "requeststatus"
    let KEY_SOCIAL_REQUEST_TYPE = "requesttype"
    let KEY_SOCIAL_STATUS = "status"
    
    var requestName:[String] = []
    var confirmdata:[String] = []
    var documentcheck:[String] = []
    var requestdate:[String] = []
    var requestid:[String] = []
    var requeststatus:[String] = []
    var requesttype:[String] = []
    var status:[String] = []
    
    var storerequestName:[String] = []
    var storeconfirmdata:[String] = []
    var storedocumentcheck:[String] = []
    var storerequestdate:[String] = []
    var storerequestid:[String] = []
    var storerequeststatus:[String] = []
    var storerequesttype:[String] = []
    var storestatus:[String] = []
    
    var searchrequestName:[String] = []
    var searchconfirmdata:[String] = []
    var searchdocumentcheck:[String] = []
    var searchrequestdate:[String] = []
    var searchrequestid:[String] = []
    var searchrequeststatus:[String] = []
    var searchrequesttype:[String] = []
    var searchstatus:[String] = []
    
    var approve = ""
    var noApproveReason = ""
    var accountID = ""
    
    var isSearch:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        
        
        searchbar.delegate = self
        searchbar.showsCancelButton = false
        
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
                
                self.getJson(json: json)
                
            }
        })
    }
    
    
    func searchApprovallist(key:String){
        
        param.search_key = key
        network.post(name: network.API_SOCIAL_WORK_APPROVE_LIST+accountID, param: param.getSearchParameter(), viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            print(Message)
            if Code == "00000"{
                self.getJson(json: json)
                
            }
        })

        
    }
    
    func getJson(json:Any){
        
        let swiftyJson = JSON(json)
        self.confirmdata = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_CONFIRM_DATA].stringValue})
        self.documentcheck = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_DOCUMENT_CHECK].stringValue})
        self.requestdate = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_DATE].stringValue})
        self.requestid = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_ID].stringValue})
        self.requeststatus = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_STATUS].stringValue})
        self.requesttype = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_REQUEST_TYPE].stringValue})
        self.requestName = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_NAME].stringValue})
        self.status = swiftyJson[self.KEY_SOCIAL_DATA][self.KEY_SOCIAL_REQUEST].arrayValue.map({$0[self.KEY_SOCIAL_STATUS].stringValue})
        
        self.countRequestLabel.text = "มีคำขอ "+String(self.requestid.count)+" ฉบับ"
        
        
        self.tableView.reloadData()
        
        print("confirmdata :",self.confirmdata);
        print("documentcheck :",self.documentcheck);
        print("requestdate :",self.requestdate);
        print("requestid :",self.requestid);
        print("requeststatus :",self.requeststatus);
        print("requesttype :",self.requesttype);
        print("requeststatus :",self.requesttype);
    }
    
    
    
    // MARK: UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchbar.text?.isEmpty)! {
            getApprovallist()
            isSearch = false
        }
        
        searchbar.showsCancelButton = true
        self.tableView.reloadData()
        // Do some search stuff
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        getApprovallist()
        isSearch = false
        self.tableView.reloadData()
        // You could also change the position, frame etc of the searchBar
    }
    
    
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        
        let text = searchBar.text
        
        if (text?.isEmpty)!{
            getApprovallist()
            isSearch = false
        }
        else{
            isSearch = true
            searchApprovallist(key: searchBar.text!)
            
        }
        self.tableView.reloadData()
    }

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestid.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getLicenseDetail(accountIDs: requestid[indexPath.row])
    }
    
    
    func getLicenseDetail(accountIDs:String){
        
        print(accountIDs)
        
        network.getWithToken(name: network.API_SOCIAL_WORK_REQUEST, param:accountIDs, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            if Code == "10000"{
                
                
            }
            else{
                let swiftyJson = JSON(json)
                self.socialWorkData.setData(json: swiftyJson)
                self.socialWorkData.setReadOnly(isReadOnly: true)
     
                self.performSegue(withIdentifier: self.LICENSE_DETAIL, sender: nil)
                
                
                
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LICENSE_DETAIL{
            let controller = segue.destination as! PsychoServiceCreateNew
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! postAdminCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        design.roundView(view: cell.confirmButton, radius: 5)
        design.roundView(view: cell.notConfirmButton, radius: 5)
        
        cell.statusCodeLabel.text = requestid[indexPath.row]
        cell.nameLabel.text = requestName[indexPath.row]
        
        
        if requesttype[indexPath.row] == "new" {
            cell.typeLabel.text = "ขอมีบัตรใหม่"
        }
        else if requesttype[indexPath.row] == "renew" {
            cell.typeLabel.text = "ขอต่ออายุ"
        }
        
        if documentcheck[indexPath.row] == "complete" {
            cell.statusDocLabel.text = "ครบ"
        }
        else if documentcheck[indexPath.row] == "" {
            cell.statusDocLabel.text = "ไม่ครบ"
        }
        
        
        cell.statusRequestLabel.text = requeststatus[indexPath.row]
       
        cell.dateLabel.text = stringHelper.getDatefromString(dateString: requestdate[indexPath.row])
        
        
        cell.confirmButton.isHidden = true
        cell.notConfirmButton.isHidden = true
        
        if status[indexPath.row] == "6" {
            
            cell.confirmButton.isHidden = false
            cell.notConfirmButton.isHidden = false
            
            cell.confirmButton.tag = indexPath.row
            cell.confirmButton.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
            
            cell.notConfirmButton.tag = indexPath.row
            cell.notConfirmButton.addTarget(self, action: #selector(notConfirmButton), for: .touchUpInside)
        }
        
        
        
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
                if self.isSearch {
                    self.searchApprovallist(key: self.searchbar.text!)
                }
                else{
                    self.getApprovallist()
                }
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
    
    @IBOutlet var nameLabel: UILabel!
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
