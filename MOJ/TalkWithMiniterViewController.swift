//
//  TalkWithMiniterViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class TalkWithMiniterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let alertView = AlertView()
    let accountData = AccountData()
    let design = Design()
    let network = Network()
    let stringHelper = StringHelper()

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var talkBarButton: UIBarButtonItem!
    @IBOutlet var loginButton: UIButton!
    let CONTACT_DETAIL = "ContactDetail"
    let KEY_CONTACTS_DATA = "data"
    let KEY_CONTACTS_DATE = "contactdattm"
    let KEY_CONTACTS_ID = "contactid"
    let KEY_CONTACTS_NAME = "contactname"
    let KEY_CONTACTS_REPLY = "contactreply"
    let KEY_CONTACTS_SHORT = "contactshort"
    let KEY_CONTACTS_USER_ID = "contactusrid"
    let KEY_CONTACTS_VIEWS = "contactviews"
    let KEY_CONTACTS_SUBJECT = "subject"
    
    var contactdattm:[String] = []
    var contactid:[String] = []
    var contactname:[String] = []
    var contactreply:[String] = []
    var contactshort:[String] = []
    var contactusrid:[String] = []
    var contactviews:[String] = []
    var subject:[String] = []
    var selectPostID:String = ""
    var selectsubject:String = ""
    var selectcontactname:String = ""
    var selectcontactdattm:String = ""
    var selectcontactviews:String = ""
    var selectcontactreply:String = ""
    var selectcontactshort:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        if accountData.isLogin() {
            talkBarButton.image = UIImage(named: "ic_chat")
            loginButton.isHidden = true
            tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        }
        else{
            talkBarButton.image = UIImage(named: "")
            loginButton.isHidden = false
            tableView.contentInset = UIEdgeInsetsMake(48, 0, 0, 0)
        }
        
        var accountID = accountData.getAccountID()

        network.get(name: network.API_CONTACTS, param:accountID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.contactdattm = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_DATE].stringValue})
            self.contactid = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_ID].stringValue})
            self.contactname = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_NAME].stringValue})
            self.contactreply = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_REPLY].stringValue})
            self.contactshort = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_SHORT].stringValue})
            self.contactusrid = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_USER_ID].stringValue})
            self.contactviews = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_VIEWS].stringValue})
            self.subject = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_SUBJECT].stringValue})
 
            self.tableView.reloadData()
        })
        
    }
    @IBAction func loginButton(_ sender: Any) {
        alertView.setMainViewController()
    }

    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactid.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPostID = contactid[indexPath.row]
        selectsubject = subject[indexPath.row]
        selectcontactname = "โดย "+contactname[indexPath.row]
        selectcontactdattm = stringHelper.getDatefromString(dateString: contactdattm[indexPath.row])
        selectcontactviews = " "+contactviews[indexPath.row]+" reviews"
        selectcontactreply = contactreply[indexPath.row]+" reply"
        selectcontactshort = contactshort[indexPath.row]
        performSegue(withIdentifier: CONTACT_DETAIL, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CONTACT_DETAIL{
            let controller = segue.destination as! TalkWithMiniterPostDetail
            controller.selectPostID = selectPostID
            controller.selectsubject = selectsubject
            controller.selectcontactname = selectcontactname
            controller.selectcontactdattm = selectcontactdattm
            controller.selectcontactviews = selectcontactviews
            controller.selectcontactreply = selectcontactreply
            controller.selectcontactshort = selectcontactshort
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! PostTalkWithMinisterCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        cell.titleLabel.text = subject[indexPath.row]
        cell.postbyLabel.text  = "โดย "+contactname[indexPath.row]
        cell.dateLabel.text  = stringHelper.getDatefromString(dateString: contactdattm[indexPath.row])
        cell.reviewerLabel.text  = " "+contactviews[indexPath.row]+" reviews"
        cell.replyLabel.text  = contactreply[indexPath.row]+" reply"
        
        return cell
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


class PostTalkWithMinisterCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postbyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
