//
//  TalkWithMinisterPostDetail.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
class TalkWithMiniterPostDetail: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    let design = Design()
    let account = AccountData()
    let alertView = AlertView()
    let network = Network()
    let accountData = AccountData()
    let stringHelper = StringHelper()
    let param = ContactsParameter()
    @IBOutlet var talkBarButton: UIBarButtonItem!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var tableView: UITableView!

    let KEY_CONTACTS_DATA = "data"
    let KEY_CONTACTS_MESSAGE = "commentmsg"
    let KEY_CONTACTS_ID = "commntid"
    let KEY_CONTACTS_NAME = "commntuname"
    let KEY_CONTACTS_USER_ID = "commntid"
    let KEY_CONTACTS_DATE = "commntdattm"
    let KEY_CONTACTS_RELATE_ID = "related_contactid"
    var commentmsg:[String] = []
    var commntdattm:[String] = []
    var commntid:[String] = []
    var commntuname:[String] = []
    var commntusrid:[String] = []
    var related_contactid:[String] = []
    
    var contactreply:String = ""
    var contactviews:String = ""
    var selectPostID:String = ""
    var contentmsgText:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        if account.isLogin() {
            talkBarButton.isEnabled = true
            talkBarButton.image = UIImage(named: "ic_chat")
            loginButton.isHidden = true
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
            
        }
        else{
            talkBarButton.isEnabled = false
            talkBarButton.image = UIImage(named: "")
            loginButton.isHidden = false
            tableView.contentInset = UIEdgeInsetsMake(48, 0, 50, 0)

        }
        
        //selectPostID+"/"+accountID
        
        let accountID = accountData.getAccountID()
        network.get(name: network.API_CONTACTS, param:"20/123", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.commentmsg = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_MESSAGE].stringValue})
            self.commntdattm = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_DATE].stringValue})
            self.commntid = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_ID].stringValue})
            self.commntuname = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_NAME].stringValue})
            self.commntusrid = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_USER_ID].stringValue})
            self.related_contactid = jsonSwifty[self.KEY_CONTACTS_DATA].arrayValue.map({$0[self.KEY_CONTACTS_RELATE_ID].stringValue})
            
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        alertView.setMainViewController()
    }
    
    
    
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commntid.count+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
     
        
        if indexPath.row == 0 {

            return 200
        }
        else{
            
            let height = commentmsg[indexPath.row-1].height(withConstrainedWidth: self.view.frame.size.width - 30, font: UIFont(name: "Quark-Bold", size: 15)!)
            return height + 120
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! PostDetailWithMinisterCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.viewMessage, radius: 5)
        design.roundViewTop(view: cell.ryplyTitleLabel, radius: 5)
        design.roundViewBottom(view: cell.viewReplyDetail, radius: 5)

        
        if indexPath.row == 0 {
            cell.viewMessage.isHidden = false
            cell.viewRyply.isHidden = true
            
//            let height = commentmsg[indexPath.row].height(withConstrainedWidth: cell.messageTextView.frame.size.width, font: UIFont(name: "Quark-Bold", size: 15)!)
//            cell.messageTextView.font = UIFont(name: "Quark-Bold", size: 15)
//            cell.messageTextView.isScrollEnabled = false
//            cell.messageTextView.text = commentmsg[indexPath.row]
//            cell.postbyLabel.text = "by "+commntuname[indexPath.row]
//            cell.dateLabel.text = stringHelper.getDatefromString(dateString: commntdattm[indexPath.row])
        }
        else{
            let height = commentmsg[indexPath.row-1].height(withConstrainedWidth: cell.ryplyDetailTextView.frame.size.width, font: UIFont(name: "Quark-Bold", size: 15)!)
            
            cell.messageReplyTextViewHeight.constant = height + 10
            cell.viewReplyHeight.constant = height + 50
            cell.ryplyDetailTextView.isScrollEnabled = false
            cell.ryplyDetailTextView.font = UIFont(name: "Quark-Bold", size: 15)
            
            cell.viewMessage.isHidden = true
            cell.viewRyply.isHidden = false
            cell.ryplyTitleLabel.text = "ตอบโดย "+commntuname[indexPath.row-1]
            cell.ryplyDetailTextView.text = commentmsg[indexPath.row-1]
            cell.ryplyDateLabel.text =  stringHelper.getDatefromString(dateString: commntdattm[indexPath.row-1])
            cell.replyComplainCodeLabel.text = String(indexPath.row)
        }
        
        return cell
    }
    
    
    func postButton(sender: UIButton!) {
        
        param.contactid =  selectPostID
        param.contentmsg = contentmsgText

        print(contentmsgText)
        
        network.post(name: network.API_CONTACTS_REPLY, param: param.getPostReplyParameter(), viewController: self, completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            if(Code == "00000"){
                
            }
            else{
                self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            }
            
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    
}

class PostDetailWithMinisterCell: UITableViewCell {
    
    @IBOutlet weak var messageTextviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewMessageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var messageReplyTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewReplyHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet weak var postbyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    
    @IBOutlet weak var viewRyply: UIView!
    @IBOutlet weak var ryplyTitleLabel: UILabel!
    @IBOutlet weak var ryplyDetailTextView: UITextView!
    @IBOutlet weak var ryplyDateLabel: UILabel!
    @IBOutlet weak var replyComplainCodeLabel: UILabel!
    
    @IBOutlet weak var viewReplyDetail: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
