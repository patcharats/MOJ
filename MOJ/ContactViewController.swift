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
class ContactViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let network = Network()
    let design = Design()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var menuButton: UIBarButtonItem!
    let CONTACT_DETAIL = "ContactDetailViewController"
    let KEY_DEPARTMENT_DATA = "data"
    let KEY_DEPARTMENT_DPIP = "dpid"
    let KEY_DEPARTMENT_NAME = "name"
    var dpid:[String] = []
    var name:[String] = []
    var selectDpid = ""
    var selectName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        
        network.get(name: network.API_DEPARTMENT, param: "", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.dpid = jsonSwifty[self.KEY_DEPARTMENT_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DPIP].stringValue})
            self.name = jsonSwifty[self.KEY_DEPARTMENT_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_NAME].stringValue})
            
            self.tableView.reloadData()

        })
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


