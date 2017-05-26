//
//  ContactViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
class ContactViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    let network = Network()
    let design = Design()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var menuButton: UIBarButtonItem!
    let CONTACT_DETAIL = "ContactDetailViewController"
    let KEY_DEPARTMENT_DATA = "data"
    let KEY_DEPARTMENT_DPIP = "id"
    let KEY_DEPARTMENT_NAME = "name"
    var dpid:[String] = []
    var name:[String] = []
    var selectDpid = ""
    var selectName = ""
    
    
    var searchdpid:[String] = []
    var searchname:[String] = []
    var storedpid:[String] = []
    var storename:[String] = []
    
    @IBOutlet var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        
        searchbar.delegate = self
        searchbar.showsCancelButton = false
        
        network.get(name: network.API_DEPARTMENT, param: "", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.dpid = jsonSwifty[self.KEY_DEPARTMENT_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DPIP].stringValue})
            self.name = jsonSwifty[self.KEY_DEPARTMENT_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_NAME].stringValue})
            
            self.storedpid = self.dpid
            self.storename = self.name
            self.tableView.reloadData()

        })
    }
    
    // MARK: UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchbar.text?.isEmpty)! {
            dpid = storedpid
            name = storename
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
        
        dpid = storedpid
        name = storename
        
        searchBar.resignFirstResponder()
        
        self.tableView.reloadData()
        // You could also change the position, frame etc of the searchBar
    }
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        
        let text = searchBar.text
        
        searchname = []
        searchdpid = []
        
        if (text?.isEmpty)!{
            name = storename
            dpid = storedpid
        }
        else{
            
            let filteredArray = storename.filter { $0.localizedCaseInsensitiveContains(text!) }
            if filteredArray.count > 0 {
                for (index, element) in storename.enumerated() {
                    if element.contains(text!){
                        searchdpid.append(storedpid[index])
                        searchname.append(storename[index])
                        
                        dpid = searchdpid
                        name = searchname
                    }
                }
            }
            else{
                dpid = []
                name = []
            }
        }
        self.tableView.reloadData()
    }

    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! contactCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        cell.titleLabel.text = name[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDpid = dpid[indexPath.row]
        selectName = name[indexPath.row]
        performSegue(withIdentifier: CONTACT_DETAIL, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CONTACT_DETAIL{
            let controller = segue.destination as! ContactDetailViewController
            controller.selectDpid = selectDpid
            controller.selectName = selectName
            
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




class contactCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


