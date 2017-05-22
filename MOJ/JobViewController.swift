//
//  JobViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class JobViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    let stringHelper = StringHelper()
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
    var selectNewsUrl:String = ""
    var selectTitle:String = ""
    let NEWS_DETAIL = "NewsDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        let accountID = accountData.getAccountID()
        network.get(name: network.API_FEED, param:accountID+"/7", viewController: self, completionHandler: {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! jobCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        cell.titleLabel.text = newstitle[indexPath.row]
        cell.titleLabel.font = UIFont(name: "Quark-Bold", size: 15)
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        cell.dateLabel.text = stringHelper.getDatefromString(dateString: lastupd[indexPath.row])
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            selectNewsUrl = newsurl[indexPath.row]
            selectTitle = newstitle[indexPath.row]
            
            performSegue(withIdentifier: NEWS_DETAIL, sender: nil)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NEWS_DETAIL{
            let controller = segue.destination as! NewDetailViewController
            controller.selectNewsUrl = selectNewsUrl
            controller.selectTitle = selectTitle
            controller.typeNew = 3
        }
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


class jobCell: UITableViewCell {
    
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

