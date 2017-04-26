//
//  TalkWithMinisterPostDetail.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class TalkWithMiniterPostDetail: UIViewController,UITableViewDelegate, UITableViewDataSource{
    let design = Design()
    let account = AccountData()
    let alertView = AlertView()
    @IBOutlet var talkBarButton: UIBarButtonItem!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        if account.isLogin() {
            talkBarButton.isEnabled = true
            talkBarButton.image = UIImage(named: "ic_chat")
            loginButton.isHidden = true
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
        }
        else{
            talkBarButton.isEnabled = false
            talkBarButton.image = UIImage(named: "")
            loginButton.isHidden = false
            tableView.contentInset = UIEdgeInsetsMake(48, 0, 0, 0)

        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        alertView.setMainViewController()
    }
    
    
    
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 256
        }
        else{
            return 157
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! PostDetailWithMinisterCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.viewMessage, radius: 5)
        design.roundView(view: cell.viewMessageBox, radius: 5)
        design.roundView(view: cell.sendMessageButton, radius: 5)
        
        if indexPath.row == 0 {
            cell.viewMessageBox.isHidden = true
        }
        else{
            cell.viewMessage.isHidden = true
        }
        
        return cell
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
    
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet weak var postbyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    
    @IBOutlet weak var viewMessageBox: UIView!
    @IBOutlet var sendMessageButton: UIButton!
    @IBOutlet var sendMessageTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
