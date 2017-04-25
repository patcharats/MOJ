//
//  TalkWithMiniterViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class TalkWithMiniterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let account = AccountData()
    let design = Design()
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var talkBarButton: UIBarButtonItem!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        if account.isLogin() {
            talkBarButton.image = UIImage(named: "ic_chat")
            loginButton.isHidden = true
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else{
            talkBarButton.image = UIImage(named: "")
            loginButton.isHidden = false
            tableView.contentInset = UIEdgeInsetsMake(48, 0, 0, 0)
        }
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! PostTalkWithMinisterCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
 
        
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
