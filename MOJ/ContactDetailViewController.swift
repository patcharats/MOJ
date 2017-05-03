//
//  ContactDetailViewController.swift
//  MOJ
//
//  Created by patcharat on 4/22/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ContactDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    let network = Network()
    let design = Design()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    let GOOGLE_URL = "http://maps.google.com/?q"
    var selectDpid = ""
    var selectName = ""
    
    let KEY_DEPARTMENT_DETAIL_DATA = "data"
    let KEY_DEPARTMENT_DETAIL_DPIP = "dpid"
    let KEY_DEPARTMENT_DETAIL_NAME = "name"
    let KEY_DEPARTMENT_DETAIL_LAT = "lat"
    let KEY_DEPARTMENT_DETAIL_LNG = "lng"
    let KEY_DEPARTMENT_DETAIL_TELEPHONE = "telephone"
    
    let KEY_DEPARTMENT_DETAIL_ADDRESS = "address"
    let KEY_DEPARTMENT_DETAIL_ADDRESS_NO = "addrno"
    let KEY_DEPARTMENT_DETAIL_BUILDING = "building"
    let KEY_DEPARTMENT_DETAIL_DISTRICT = "district"
    let KEY_DEPARTMENT_DETAIL_PROVINCE = "province"
    let KEY_DEPARTMENT_DETAIL_SUB_DISTRICT = "sub_district"
    
    var dpid:[String] = []
    var name:[String] = []
    var lat:[String] = []
    var lng:[String] = []
    var telephone:[String] = []
    var addrno:[String] = []
    var building:[String] = []
    var district:[String] = []
    var province:[String] = []
    var sub_district:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectName
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        print(selectDpid)
        network.get(name: network.API_DEPARTMENT, param: selectDpid, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)

            self.dpid = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_DPIP].stringValue})
            self.name = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_NAME].stringValue})
            self.lat = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LAT].stringValue})
            self.lng = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LNG].stringValue})
            
            print(self.name)
            self.tableView.reloadData()
        })
        
        
    }
    
    
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! contactDetailCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        design.roundView(view: cell.headerLabel, radius: 5)
        
        if lat[indexPath.row] .contains("0.00") && lng [indexPath.row] .contains("0.00"){
            cell.mapButton.isHidden = true
        }
        
        cell.addressTextView.font = UIFont(name: "Quark-Bold", size: 15)
        cell.titleLabel.text = name[indexPath.row]
        cell.mapButton.addTarget(self, action: #selector(mapButton), for: .touchUpInside)
        cell.mapButton.tag = indexPath.row
        
        return cell
    }
    func mapButton(sender: UIButton!) {
        openGoogleMap(lat: lat[sender.tag], long: lng[sender.tag])
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func openGoogleMap(lat:String,long:String){
        
        let stringUrl = String.init(format: "%@=%@,%@",GOOGLE_URL, lat,long)
        let url = URL(string: stringUrl)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    

}

class contactDetailCell: UITableViewCell {
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var addressTextView: UITextView!
    @IBOutlet var mapButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
