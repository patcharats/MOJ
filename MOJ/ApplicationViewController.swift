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
class ApplicationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet var menuButton: UIBarButtonItem!
    let network = Network()
    let design = Design()
    let stringHelper = StringHelper()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var searchbar: UISearchBar!
    let KEY_APP_DATA = "data"
    let KEY_APP_ID = "appid"
    let KEY_APP_NAME = "name"
    let KEY_APP_DESC = "desc"
    let KEY_APP_IOS = "appstoreid"
    let KEY_APP_ANDR = "playstoreid"
    let KEY_APP_THUMBNAIL = "thumbnail"
    
    var storeappid:[String] = []
    var storedesc:[String] = []
    var storename:[String] = []
    var storeappstoreid:[String] = []
    var storeplaystoreid:[String] = []
    var storethumbnail:[String] = []
    
    var appid:[String] = []
    var desc:[String] = []
    var name:[String] = []
    var appstoreid:[String] = []
    var playstoreid:[String] = []
    var thumbnail:[String] = []
    
    
    var searchappid:[String] = []
    var searchdesc:[String] = []
    var searchname:[String] = []
    var searchappstoreid:[String] = []
    var searchplaystoreid:[String] = []
    var searchthumbnail:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        searchbar.delegate = self
        searchbar.showsCancelButton = false

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        network.get(name: network.API_APPLICATION, param:"", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.appid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_ID].stringValue})
            self.name = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_NAME].stringValue})
            self.desc = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_DESC].stringValue})
            self.appstoreid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_IOS].stringValue})
            self.playstoreid = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_ANDR].stringValue})
            self.thumbnail = jsonSwifty[self.KEY_APP_DATA].arrayValue.map({$0[self.KEY_APP_THUMBNAIL].stringValue})
            
            
            self.storeappid = self.appid
            self.storename = self.name
            self.storedesc = self.desc
            self.storeappstoreid = self.appstoreid
            self.storeplaystoreid = self.playstoreid
            self.storethumbnail = self.thumbnail
            
            self.tableView.reloadData()
            
        })
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchbar.text?.isEmpty)! {
            
            appid = storeappid
            name = storename
            desc = storedesc
            appstoreid = storeappstoreid
            playstoreid = storeplaystoreid
            thumbnail = storethumbnail
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
        
        appid = storeappid
        name = storename
        desc = storedesc
        appstoreid = storeappstoreid
        playstoreid = storeplaystoreid
        thumbnail = storethumbnail
        
        searchBar.resignFirstResponder()
        
        self.tableView.reloadData()
        // You could also change the position, frame etc of the searchBar
    }
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){

        let text = searchBar.text
        
        searchappid = []
        searchname  = []
        searchdesc = []
        searchappstoreid = []
        searchplaystoreid = []
        searchthumbnail = []
        
        if (text?.isEmpty)!{
            appid = storeappid
            name = storename
            desc = storedesc
            appstoreid = storeappstoreid
            playstoreid = storeplaystoreid
            thumbnail = storethumbnail
        }
        else{
            
            let filteredArray = storename.filter { $0.localizedCaseInsensitiveContains(text!) }
            if filteredArray.count > 0 {
                for (index, element) in storename.enumerated() {
                    if element.contains(text!){
                        searchappid.append(storeappid[index])
                        searchname.append(storename[index])
                        searchdesc.append(storedesc[index])
                        searchappstoreid.append(storeappstoreid[index])
                        searchplaystoreid.append(storeplaystoreid[index])
                        searchthumbnail.append(storethumbnail[index])
                        
                        appid = searchappid
                        name = searchname
                        desc = searchdesc
                        appstoreid = searchappstoreid
                        playstoreid = searchplaystoreid
                        thumbnail = searchthumbnail
                    }
                }
            }
            else{
                    appid = []
                    name = []
                    desc = []
                    appstoreid = []
                    playstoreid = []
                    thumbnail = []
            }
            
            
            
            
        }
        self.tableView.reloadData()
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
        cell.logoImageView.sd_setImage(with: URL(string: thumbnail[indexPath.row]), placeholderImage: UIImage(named: "image_def_bog"))
        
        
        if stringHelper.verifyUrl(urlString: playstoreid[indexPath.row]) {
            cell.androidButton.isHidden = false
            cell.androidButton.tag = indexPath.row
            cell.androidButton.addTarget(self, action: #selector(androidButton), for: .touchUpInside)
        }
        else{
            cell.androidButton.isHidden = true
        }
        
        if stringHelper.verifyUrl(urlString: appstoreid[indexPath.row]) {
            cell.iosButton.isHidden = false
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
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func iosButton(sender: UIButton!) {
        let url = NSURL(string: appstoreid[sender.tag])
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
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

