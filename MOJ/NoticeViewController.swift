//
//  NoticeViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON 
class NoticeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    var newsgrpid:[Int] = []
    var lastupd:[String] = []
    var newsthumb:[String] = []
    var newstitle:[String] = []
    var newsurl:[String] = []
    
    let KEY_NEWS_DATA = "data"
    let KEY_NEWS_GROUP_ID = "newsgrpid"
    let KEY_NEWS_THUMPNAIL = "newsthumb"
    let KEY_NEWS_TITLE = "newstitle"
    let KEY_NEWS_URL = "newsurl"
    let KEY_NEWS_LAST_UPDATE = "lastupd"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        let accountID = accountData.getAccountID()
        
        network.get(name: network.API_FEED, param:accountID+"/6", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.lastupd = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_LAST_UPDATE].stringValue})
            self.newsthumb = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_THUMPNAIL].stringValue})
            self.newstitle = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_TITLE].stringValue})
            self.newsurl = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_URL].stringValue})
            
            
            
            self.tableView.reloadData()
            
        })
    }
    
    
    

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newstitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! noticeCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        cell.titleLabel.text = newstitle[indexPath.row]
        cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.titleLabel.numberOfLines = 3
        cell.dateLabel.text = lastupd[indexPath.row]
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
class noticeCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


