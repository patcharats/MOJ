//
//  ComplainViewController.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class ComplainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let design = Design()
    let network = Network()
    let accountData = AccountData()
    let stringHelper = StringHelper()
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var addButton: UIBarButtonItem!
    let COMPLAIN_DETAIL = "ComplainDetail"
    let KEY_COMPLAIN_DATA = "data"
    let KEY_COMPLAIN_CATAGORIE_ID = "cmpltcatid"
    let KEY_COMPLAIN_CODE = "cmpltcode"
    let KEY_COMPLAIN_CONTENT = "cmpltcontent"
    let KEY_COMPLAIN_CONTENT_ID = "cmpltconttentid"
    let KEY_COMPLAIN_DATE = "cmpltdattm"
    let KEY_COMPLAIN_ID = "cmpltid"
    let KEY_COMPLAIN_STATUS = "cmpltstatus"
    let KEY_COMPLAIN_SUBJECT = "cmpltsubject"
    let KEY_COMPLAIN_USER_ID = "cmpltuserid"
    
    var cmpltcatid:[String] = []
    var cmpltcode:[String] = []
    var cmpltcontent:[String] = []
    var cmpltconttentid:[String] = []
    var cmpltid:[String] = []
    var cmpltdattm:[String] = []
    var cmpltstatus:[String] = []
    var cmpltsubject:[String] = []
    var cmpltuserid:[String] = []
    
    var selectComplaintID:String = ""
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataLabel.isHidden = true
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        if accountData.isLogin() {
            addButton.image = UIImage(named:"ic_add")
            addButton.isEnabled = true
        }
        else{
            addButton.image = UIImage(named:"")
            addButton.isEnabled = false
        }
        
        let accountID = accountData.getAccountID()
        var param = accountID
        param = "1"
        network.get(name: network.API_COMPLAINTS, param: param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.cmpltcatid = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_CATAGORIE_ID].stringValue})
            self.cmpltcode = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_CODE].stringValue})
            self.cmpltcontent = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_CONTENT].stringValue})
            self.cmpltconttentid = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_CONTENT_ID].stringValue})
            self.cmpltid = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_ID].stringValue})
            self.cmpltdattm = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_DATE].stringValue})
            self.cmpltstatus = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_STATUS].stringValue})
            self.cmpltsubject = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_SUBJECT].stringValue})
            self.cmpltuserid = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_USER_ID].stringValue})
            
            if self.cmpltid.isEmpty {
                self.noDataLabel.isHidden = false
                self.tableView.isHidden = true
            }
            else{
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            
        })
    }

    
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cmpltid.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! complainCell
        cell.backgroundColor = UIColor.clear
        design.roundViewTop(view: cell.titleLabel, radius: 5)
        design.roundViewBottom(view: cell.view, radius: 5)
        design.roundView(view: cell.proceedLabel, radius: 5)
        cell.titleLabel.text = cmpltsubject[indexPath.row]
        cell.detailLabel.text = cmpltcontent[indexPath.row]
        cell.complainCodeLabel.text = cmpltcode[indexPath.row]
        design.getProcessStatus(status: cmpltstatus[indexPath.row], label: cell.proceedLabel)
        cell.dateLabel.text = stringHelper.getDatefromString(dateString: cmpltdattm[indexPath.row])
        cell.alertImage.isHidden = true
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectComplaintID = cmpltid[indexPath.row]
        performSegue(withIdentifier: COMPLAIN_DETAIL, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == COMPLAIN_DETAIL{
            let controller = segue.destination as! ComplainDetail
            controller.selectComplaintID = selectComplaintID
            
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

class complainCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var complainCodeLabel: UILabel!
    @IBOutlet weak var proceedLabel: UILabel!

    @IBOutlet var alertImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
