//
//  TalkWithMinisterPostDetail.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
import GrowingTextView

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
    var contentmsgText:String = ""
    
    var selectPostID:String = ""
    var selectsubject:String = ""
    var selectcontactname:String = ""
    var selectcontactdattm:String = ""
    var selectcontactviews:String = ""
    var selectcontactreply:String = ""
    var selectcontactshort:String = ""
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var commentTexfield: UITextField!
    
    
    @IBOutlet weak var inputToolbar: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint! //*** Bottom Constraint of toolbar ***
    @IBOutlet weak var textView: GrowingTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        self.title = selectsubject
        design.roundView(view: sendButton, radius: 5)
        if account.isLogin() {
            talkBarButton.isEnabled = true
            talkBarButton.image = UIImage(named: "ic_chat")
            loginButton.isHidden = true
            tableView.contentInset = UIEdgeInsetsMake(8, 0, 50, 0)
            
        }
        else{
            talkBarButton.isEnabled = false
            talkBarButton.image = UIImage(named: "")
            loginButton.isHidden = false
            tableView.contentInset = UIEdgeInsetsMake(48, 0, 50, 0)

        }
        
        getDetailPost()
        
        
        // *** Listen for keyboard show / hide ***
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // *** Hide keyboard when tapping outside ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    func tapGestureHandler() {
        view.endEditing(true)
    }
    
    func getDetailPost(){
        // selectPostID+"/"+accountID
        // "20/123"
        let accountID = accountData.getAccountID()
        network.get(name: network.API_CONTACTS, param:selectPostID+"/"+accountID, viewController: self, completionHandler: {
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
        
        tableView.updateConstraintsIfNeeded()
        tableView.updateConstraints()
        tableView.layoutIfNeeded()
        tableView.setNeedsLayout()
        
        
        if indexPath.row == 0 {

            let height = selectcontactshort.height(withConstrainedWidth: self.view.frame.size.width - 30, font: UIFont(name: "Quark-Bold", size: 15)!)
            return height + 50
        }
        else{
            
            let height = commentmsg[indexPath.row-1].height(withConstrainedWidth: self.view.frame.size.width - 30, font: UIFont(name: "Quark-Bold", size: 15)!)
            print("\(indexPath.row) - Height :\(height + 120)")
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
            let height = selectcontactshort.height(withConstrainedWidth: self.view.frame.size.width - 30, font: UIFont(name: "Quark-Bold", size: 15)!)
            cell.messageTextviewHeight.constant = height + 50
            cell.viewMessageHeight.constant = height + 50
            cell.messageTextView.font = UIFont(name: "Quark-Bold", size: 15)
            cell.messageTextView.isScrollEnabled = false
            cell.messageTextView.isSelectable = false
            cell.messageTextView.isEditable = false
            cell.messageTextView.text = selectcontactshort
            cell.postbyLabel.text = selectcontactname
            cell.dateLabel.text = selectcontactdattm
            cell.reviewerLabel.text = selectcontactviews
            cell.replyLabel.text = selectcontactreply

            
        }
        else{
            cell.viewMessage.isHidden = true
            cell.viewRyply.isHidden = false
            
            let height = commentmsg[indexPath.row-1].height(withConstrainedWidth: cell.ryplyDetailTextView.frame.size.width, font: UIFont(name: "Quark-Bold", size: 15)!)
            cell.messageReplyTextViewHeight.constant = height + 50
            cell.viewReplyHeight.constant = height + 100
            cell.viewReplyDetailHeight.constant = height + 44
            
            
            cell.ryplyDetailTextView.isScrollEnabled = false
            cell.ryplyDetailTextView.isSelectable = false
            cell.ryplyDetailTextView.isEditable = false
            cell.ryplyDetailTextView.font = UIFont(name: "Quark-Bold", size: 15)
            
            
            cell.ryplyTitleLabel.text = "ตอบโดย "+commntuname[indexPath.row-1]
            cell.ryplyDetailTextView.text = commentmsg[indexPath.row-1]
            cell.ryplyDateLabel.text =  stringHelper.getDatefromString(dateString: commntdattm[indexPath.row-1])
            cell.replyComplainCodeLabel.text = String(indexPath.row)
            
            
        }
    
        
        
        return cell
    }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        contentmsgText = textView.text!
        param.contactid =  selectPostID
        param.contentmsg = contentmsgText
        
        print(contentmsgText)
        
        network.post(name: network.API_CONTACTS_REPLY, param: param.getPostReplyParameter(), viewController: self, completionHandler: {
            (JSON : Any,Code:String,Message:String) in
            
            if(Code == "00000"){
                self.getDetailPost()
                self.textView.text = ""
                self.textView.resignFirstResponder()
            }
            else{
                
            }
            
            self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            
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

extension TalkWithMiniterPostDetail: GrowingTextViewDelegate {
    
    // *** Call layoutIfNeeded on superview for animation when changing height ***
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

class PostDetailWithMinisterCell: UITableViewCell {
    
    @IBOutlet weak var messageTextviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewMessageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var messageReplyTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewReplyHeight: NSLayoutConstraint!
    
    @IBOutlet var viewReplyDetailHeight: NSLayoutConstraint!
    
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
        
        self.updateConstraintsIfNeeded()
        self.updateConstraints()
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
