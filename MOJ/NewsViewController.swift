//
//  NewsViewController.swift
//  MOJ
//
//  Created by patcharat on 4/22/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SDWebImage

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    let stringHelper = StringHelper()
    let alertView = AlertView()
    
    @IBOutlet weak var viewGroupBackground: UIView!
    @IBOutlet weak var tableViewGroup: UITableView!
    @IBOutlet weak var viewGroup: UIView!
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var confirmFilterButton: UIButton!
    var newsgrpid:[Int] = []
    var lastupd:[String] = []
    var newsthumb:[String] = []
    var newstitle:[String] = []
    var newsurl:[String] = []
    var selectNewsUrl:String = ""
    var selectTitle:String = ""
    let NEWS_DETAIL = "NewsDetailViewController"
    let KEY_NEWS_DATA = "data"
    let KEY_NEWS_GROUP_ID = "newsgrpid"
    let KEY_NEWS_THUMPNAIL = "newsthumb"
    let KEY_NEWS_TITLE = "newstitle"
    let KEY_NEWS_URL = "newsurl"
    let KEY_NEWS_LAST_UPDATE = "lastupd"
    
    
    var groupNewsgrpid:[String] = []
    var groupNewsgrpurl:[String] = []
    var groupNewsowner:[String] = []
    var groupRecvstatus:[Bool] = []
    
    let KEY_NEWS_GROUP_URL = "newsgrpurl"
    let KEY_NEWS_GROUP_OWNER = "newsowner"
    let KEY_NEWS_RECEIVE_STATUS = "recvstatus"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewGroup.delegate = self
        tableViewGroup.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableViewGroup.backgroundColor = UIColor.clear
        viewGroupBackground.isHidden = true
        
        viewGroupBackground.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.bringSubview(toFront: viewGroupBackground)
        design.roundView(view: viewGroup, radius: 5)
        design.roundView(view: confirmFilterButton, radius: 5)
        
        let accountID = accountData.getAccountID()
        
        if accountID.characters.count < 1{
            accountID == "0"
        }
        
        network.get(name: network.API_FEED_STATUS, param:accountID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.groupNewsgrpid = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_GROUP_ID].stringValue})
            self.groupNewsgrpurl = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_GROUP_URL].stringValue})
            self.groupNewsowner = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_GROUP_OWNER].stringValue})
            self.groupRecvstatus = jsonSwifty[self.KEY_NEWS_DATA].arrayValue.map({$0[self.KEY_NEWS_RECEIVE_STATUS].boolValue})
            
            self.tableViewGroup.reloadData()
        })
        
        network.get(name: network.API_FEED, param:accountID, viewController: self, completionHandler: {
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
        if tableView == tableViewGroup {
            return groupNewsgrpid.count
        }
        else{
            return newstitle.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewGroup {
        }
        else{
            selectNewsUrl = newsurl[indexPath.row]
            selectTitle = newstitle[indexPath.row]
            
            performSegue(withIdentifier: NEWS_DETAIL, sender: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewGroup {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! newsGroupCell
            cell.titleLabel.text = groupNewsowner[indexPath.row]
            
            var imageRedio = "radio_off"
            if groupRecvstatus[indexPath.row] {
                imageRedio = "radio_on"
            }
            cell.redioButton.tag = indexPath.row
            cell.redioButton.addTarget(self, action: #selector(redioButton), for: .touchUpInside)
            cell.redioButton.setImage(UIImage (named: imageRedio), for: UIControlState.normal)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! newsCell
            cell.backgroundColor = UIColor.clear
            design.roundView(view: cell.view, radius: 5)
            cell.titleLabel.text = newstitle[indexPath.row]
            cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.titleLabel.numberOfLines = 3
            cell.dateLabel.text = lastupd[indexPath.row]
            cell.newsImageView.sd_setImage(with: URL(string: newsthumb[indexPath.row]), placeholderImage: UIImage(named: "image_def_bog"))
            return cell
        }
    }
    
    
    func redioButton(sender: UIButton!) {
        let status = groupRecvstatus[sender.tag]
        groupRecvstatus[sender.tag] = !status
        tableViewGroup.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NEWS_DETAIL{
            let controller = segue.destination as! NewDetailViewController
            controller.selectNewsUrl = selectNewsUrl
            controller.selectTitle = selectTitle
        }
    }
    @IBAction func filterButton(_ sender: Any) {
        
        if network.isInternetAvailable() {
            viewGroupBackground.isHidden = false
        }
        else{
            alertView.alert(title: "", message: alertView.ALERT_NEWS_NO_INTERNET, buttonTitle: alertView.ALERT_OK, controller: self)
        }
        
    }
    @IBAction func confirmFilterButton(_ sender: Any) {
        viewGroupBackground.isHidden = true
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


class newsCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


class newsGroupCell: UITableViewCell {
    
    @IBOutlet weak var redioButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
