//
//  ApplicationViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class ApplicationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var menuButton: UIBarButtonItem!
    let network = Network()
    let design = Design()
    let stringHelper = StringHelper()
    @IBOutlet weak var tableView: UITableView!
    
    let KEY_APP_DATA = "data"
    let KEY_APP_ID = "appid"
    let KEY_APP_NAME = "name"
    let KEY_APP_DESC = "desc"
    let KEY_APP_IOS = "appstoreid"
    let KEY_APP_ANDR = "playstoreid"
    
    var appid:[String] = []
    var desc:[String] = []
    var name:[String] = []
    var appstoreid:[String] = []
    var playstoreid:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        network.get(name: network.API_APPLICATION, param:"", completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.appid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_ID].stringValue})
            self.name = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_NAME].stringValue})
            self.desc = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_DESC].stringValue})
            self.appstoreid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_IOS].stringValue})
            self.playstoreid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_ANDR].stringValue})
            
            self.tableView.reloadData()
            
        })
    }

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! appCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        
        cell.titleLabel.text = name[indexPath.row]
        cell.descLabel.text = desc[indexPath.row]
        
        
        if stringHelper.verifyUrl(urlString: playstoreid[indexPath.row]) {
            cell.androidButton.tag = indexPath.row
            cell.androidButton.addTarget(self, action: #selector(androidButton), for: .touchUpInside)
        }
        else{
            cell.androidButton.isHidden = true
        }
        
        if stringHelper.verifyUrl(urlString: appstoreid[indexPath.row]) {
            cell.iosButton.tag = indexPath.row
            cell.iosButton.addTarget(self, action: #selector(iosButton), for: .touchUpInside)
        }
        else{
            cell.iosButton.isHidden = true
        }
        
        return cell
    }
    
    func androidButton(sender: UIButton!) {
        let url = NSURL(string: playstoreid[sender.tag])
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
    func iosButton(sender: UIButton!) {
        let url = NSURL(string: appstoreid[sender.tag])
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
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


class appCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var iosButton: UIButton!
    @IBOutlet var androidButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

