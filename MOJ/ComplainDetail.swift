//
//  ComplainDetail.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
class ComplainDetail: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    let design = Design()
    let network = Network()
    let accountData = AccountData()
    var selectComplaintID:String = ""
    let stringHelper = StringHelper()
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var replyTextfield: UITextField!
    
    // detail
    
    
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
    let KEY_COMPLAIN_IMAGE = "image"
    let KEY_COMPLAIN_IMAGE_ID = "cpltImgId"
    let KEY_COMPLAIN_IMAGE_NAME = "cpltImgRename"
    
    var cmpltcatid:String = ""
    var cmpltcode:String = ""
    var cmpltcontent:String = ""
    var cmpltconttentid:String = ""
    var cmpltid:String = ""
    var cmpltdattm:String = ""
    var cmpltstatus:String = ""
    var cmpltsubject:String = ""
    var cmpltuserid:String = ""
    var images:[String:Any] = [:]
    var cpltImgId:[String] = []
    var cpltImgRename:[String] = []
    
    // reply
    
    let KEY_COMPLAIN_INST_NAME = "instName"
    let KEY_COMPLAIN_REPLY_DATE = "reptDateTime"
    let KEY_COMPLAIN_REPLY_DETAIL = "reptDetail"
    let KEY_COMPLAIN_REPLY_ID = "reptId"
    let KEY_COMPLAIN_REPLY_STATUS = "respStatus"
    
    var instName:[String] = []
    var reptDateTime:[String] = []
    var reptDetail:[String] = []
    var reptId:[String] = []
    var respStatus:[String] = []
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        design.roundView(view: sendButton, radius: 5)
        if accountData.isLogin() {
            addButton.image = UIImage(named: "ic_add")
            addButton.isEnabled = true
        }
        else{
            addButton.image = UIImage(named: "")
            addButton.isEnabled = false
        }
        
        let accountID = accountData.getAccountID()
        var param = accountID+"/"+selectComplaintID
        network.get(name: network.API_COMPLAINT, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            
            self.cmpltcatid = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_CATAGORIE_ID].stringValue
            self.cmpltcode = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_CODE].stringValue
            self.cmpltcontent = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_CONTENT].stringValue
            self.cmpltconttentid = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_CONTENT_ID].stringValue
            self.cmpltid = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_ID].stringValue
            self.cmpltdattm = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_DATE].stringValue
            self.cmpltstatus = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_STATUS].stringValue
            self.cmpltsubject = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_SUBJECT].stringValue
            self.cmpltuserid = jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_USER_ID].stringValue
            self.cpltImgId =  (jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_IMAGE].arrayValue.map({$0[self.KEY_COMPLAIN_IMAGE_ID].stringValue}))
            self.cpltImgRename =  (jsonSwifty[self.KEY_COMPLAIN_DATA][self.KEY_COMPLAIN_IMAGE].arrayValue.map({$0[self.KEY_COMPLAIN_IMAGE_NAME].stringValue}))
            
            print(self.cpltImgRename)
            
            
            self.network.get(name: self.network.API_COMPLAINT_REPLY, param: "1"+"/"+self.selectComplaintID, viewController: self, completionHandler: {
                (json:Any,Code:String,Message:String) in
                let jsonSwifty = JSON(json)
                self.instName = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_INST_NAME].stringValue})
                self.reptDateTime = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_REPLY_DATE].stringValue})
                self.reptDetail = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_REPLY_DETAIL].stringValue})
                self.reptId = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_REPLY_ID].stringValue})
                self.respStatus = jsonSwifty[self.KEY_COMPLAIN_DATA].arrayValue.map({$0[self.KEY_COMPLAIN_REPLY_STATUS].stringValue})
                
                self.tableView.reloadData()
            })
        })
        
        
        
    }
    

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reptId.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 280
        }
        else{
            return 174
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! complainDetailCell
        cell.backgroundColor = UIColor.clear
        design.roundViewTop(view: cell.ryplyTitleLabel, radius: 5)
        design.roundViewBottom(view: cell.viewRyply, radius: 5)
        design.roundViewTop(view: cell.titleLabel, radius: 5)
        design.roundViewBottom(view: cell.viewDetail, radius: 5)
        design.roundView(view: cell.proceedLabel, radius: 5)
        cell.detailTextView.font = UIFont(name: "Quark-Bold", size: 15)
        
        
        if indexPath.row == 0 {
            cell.viewDetail.isHidden = false
            cell.viewRyply.isHidden = true
            
            cell.detailTextView.text = cmpltcontent
            cell.titleLabel.text = cmpltsubject
            
            cell.dateLabel.text = stringHelper.getDatefromString(dateString: cmpltdattm)
            cell.complainCodeLabel.text = cmpltcode
            cell.proceedLabel.text = cmpltstatus
            design.getProcessStatus(status: cmpltstatus, label: cell.proceedLabel)
            cell.alertImage.isHidden = true
            
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.backgroundColor = UIColor.clear
            
            cell.collectionView.reloadData()
            
        }
        else{
            cell.viewDetail.isHidden = true
            cell.viewRyply.isHidden = false
            cell.ryplyDetailLabel.text = reptDetail[indexPath.row-1]
            cell.ryplyDateLabel.text = stringHelper.getDatefromString(dateString: reptDateTime[indexPath.row-1])
            cell.replyComplainCodeLabel.text = ""
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionCell
        cell.backgroundColor = UIColor.clear
        cell.imageView.sd_setImage(with: URL(string: cpltImgRename[indexPath.row]), placeholderImage: UIImage(named: "image_def_bog"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cpltImgRename.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


class complainDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var complainCodeLabel: UILabel!
    @IBOutlet weak var proceedLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!

    @IBOutlet weak var viewRyply: UIView!
    @IBOutlet weak var ryplyTitleLabel: UILabel!
    @IBOutlet weak var ryplyDetailLabel: UILabel!
    @IBOutlet weak var ryplyDateLabel: UILabel!
    @IBOutlet weak var replyComplainCodeLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class imageCollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var removeImage: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
