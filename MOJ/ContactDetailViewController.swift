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

class ContactDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,UISearchBarDelegate,UITextViewDelegate{
    
    let param = DepartmentParameter()
    @IBOutlet var searchbar: UISearchBar!
    
    let network = Network()
    let design = Design()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    let GOOGLE_URL = "http://maps.google.com/?q"
    var selectDpid = ""
    var selectName = ""
    let KEY_DEPARTMENT_DETAIL_RESULTS = "results"
    let KEY_DEPARTMENT_DETAIL_ALL_ITEM = "all_item"
    let KEY_DEPARTMENT_DETAIL_CURRENT_PAGE = "current_page"
    let KEY_DEPARTMENT_DETAIL_PER_PAGE = "perpage"
    
    let KEY_DEPARTMENT_DETAIL_DATA = "data"
    let KEY_DEPARTMENT_DETAIL_DPIP = "dpid"
    let KEY_DEPARTMENT_DETAIL_NAME = "name"
    let KEY_DEPARTMENT_DETAIL_LAT = "lat"
    let KEY_DEPARTMENT_DETAIL_LNG = "lng"
    let KEY_DEPARTMENT_DETAIL_TELEPHONE = "telephone"
    
    let KEY_DEPARTMENT_DETAIL_ADDRESS = "address"
    let KEY_DEPARTMENT_DETAIL_ADDRESS_NO = "no"
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
    var isCenter:[Bool] = []
    var isFirst:[Bool] = []
    var center_item:String = ""
    
    var center_dpid:[String] = []
    var center_name:[String] = []
    var center_lat:[String] = []
    var center_lng:[String] = []
    var center_telephone:[String] = []
    var center_addrno:[String] = []
    var center_building:[String] = []
    var center_district:[String] = []
    var center_province:[String] = []
    var center_sub_district:[String] = []
    var center_isCenter:[Bool] = []
    var center_isFirst:[Bool] = []
    var center_center_item:String = ""
    
    var KEY_CENTER = "?center=1"
    var KEY_DISTRICT = "?center!=1"
    var KEY_ID = "&id="
    
    var all_item = 0.0
    var current_page = 1
    var perpage = 0.0
    var numberOfpage = 0
    var continueDetail = true
    
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectName
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear

        print(selectDpid)
        searchbar.delegate = self
        searchbar.showsCancelButton = false
        
        getDepartmentData()
    }
    
    func getDepartmentData(){
        network.get(name: network.API_DEPARTMENT, param: selectDpid+KEY_CENTER+KEY_ID, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            
            self.dpid = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_DPIP].stringValue})
            self.name = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_NAME].stringValue})
            self.lat = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LAT].stringValue})
            self.lng = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LNG].stringValue})
            self.telephone = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_TELEPHONE].stringValue})
            
            
            self.addrno = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_ADDRESS_NO].stringValue})
            self.building = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_BUILDING].stringValue})
            self.district = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_DISTRICT].stringValue})
            self.province = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_PROVINCE].stringValue})
            self.sub_district = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_ADDRESS_NO].stringValue})
            
            self.center_item = String(self.dpid.count)
            
            for (index,_) in self.dpid.enumerated() {
                if index == 0 {
                    self.isFirst.append(true)
                }
                else{
                    self.isFirst.append(false)
                }
                
                self.isCenter.append(true)
            }
            
            
            self.center_dpid = self.dpid
            self.center_name = self.name
            self.center_lat = self.lat
            self.center_lng = self.lng
            self.center_telephone = self.telephone
            self.center_addrno = self.addrno
            self.center_building = self.building
            self.center_district = self.district
            self.center_province = self.province
            self.center_sub_district = self.sub_district
            self.center_isCenter = self.isCenter
            self.center_isFirst = self.isFirst
            self.center_center_item = self.center_item
            
            self.getDistrictDetail()
            
        })
    }
    
    
    func getDistrictDetail(){
        self.network.get(name: self.network.API_DEPARTMENT, param: self.selectDpid+self.KEY_DISTRICT+KEY_ID+String(current_page), viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.getDistrictData(json: json)
            
        })
    }
    
    func getDistrictData(json:Any){
        let jsonSwifty = JSON(json)
        self.current_page = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_CURRENT_PAGE].intValue
        self.perpage = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_PER_PAGE].doubleValue
        self.all_item = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_ALL_ITEM].doubleValue
        
        self.numberOfpage = Int(ceil(self.all_item/self.perpage))
        
        print(self.numberOfpage)
        
        let dpid2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_DPIP].stringValue})
        let name2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_NAME].stringValue})
        let lat2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LAT].stringValue})
        let lng2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_LNG].stringValue})
        
        let telephone2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_TELEPHONE].stringValue})
        
        let addrno2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_ADDRESS_NO].stringValue})
        let building2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_BUILDING].stringValue})
        let district2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_DISTRICT].stringValue})
        let province2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_PROVINCE].stringValue})
        let sub_district2 = jsonSwifty[self.KEY_DEPARTMENT_DETAIL_DATA][self.KEY_DEPARTMENT_DETAIL_RESULTS].arrayValue.map({$0[self.KEY_DEPARTMENT_DETAIL_ADDRESS][self.KEY_DEPARTMENT_DETAIL_SUB_DISTRICT].stringValue})
        
        
        for (index,_) in dpid2.enumerated() {
            if self.current_page == 1{
                if index == 0 {
                    self.isFirst.append(true)
                }
                else{
                    self.isFirst.append(false)
                }
            }
            else{
                self.isFirst.append(false)
            }
            
            
            self.isCenter.append(false)
        }
        
        
        self.dpid = self.dpid + dpid2
        self.name = self.name + name2
        self.lat = self.lat + lat2
        self.lng = self.lng + lng2
        self.telephone = self.telephone + telephone2
        self.addrno = self.addrno + addrno2
        self.building = self.building + building2
        self.district = self.district + district2
        self.sub_district = self.sub_district + sub_district2
        self.province = self.province + province2
        
        self.continueDetail = true
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchbar.showsCancelButton = true
        
        if (searchbar.text?.isEmpty)! {
            self.dpid = []
            self.name = []
            self.lat = []
            self.lng = []
            self.telephone = []
            self.addrno = []
            self.building = []
            self.district = []
            self.province = []
            self.sub_district = []
            self.isCenter = []
            self.isFirst = []
            
            current_page = 1
            getDepartmentData()
        }
        else{
            print("not empty");
        }
    
        // Do some search stuff
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false

        self.dpid = []
        self.name = []
        self.lat = []
        self.lng = []
        self.telephone = []
        self.addrno = []
        self.building = []
        self.district = []
        self.province = []
        self.sub_district = []
        self.isCenter = []
        self.isFirst = []
        
        current_page = 1
        getDepartmentData()
        
        searchBar.resignFirstResponder()
        isSearch = false
        
        self.tableView.reloadData()
        // You could also change the position, frame etc of the searchBar
    }
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        
        isSearch = true
        searchBar.resignFirstResponder()
        
        self.dpid = []
        self.name = []
        self.lat = []
        self.lng = []
        self.telephone = []
        self.addrno = []
        self.building = []
        self.district = []
        self.province = []
        self.sub_district = []
        self.isCenter = []
        self.isFirst = []
        
        let text = searchBar.text
        
        if (text?.isEmpty)! {
            getDepartmentData()
        }
        else{
            let filteredArray = center_name.filter { $0.localizedCaseInsensitiveContains(text!) }
            if filteredArray.count > 0 {
                for (index, element) in center_name.enumerated() {
                    if element.contains(text!){
                        
                        if current_page == 1 {
                        dpid.append(center_dpid[index])
                        name.append(center_name[index])
                        lat.append(center_lat[index])
                        lng.append(center_lng[index])
                        telephone.append(center_telephone[index])
                        addrno.append(center_addrno[index])
                        building.append(center_building[index])
                        district.append(center_district[index])
                        province.append(center_province[index])
                        sub_district.append(center_sub_district[index])
                        isCenter.append(center_isCenter[index])
                        isFirst.append(center_isFirst[index])
                        }
                    }
                    
                }
            }
            
            searchDepertment()
            
        }
        
        
    }
    
    func searchDepertment(){
        
        param.q = searchbar.text!
        param.page = current_page
        param.type = self.selectDpid
        
        network.post(name: network.API_DEPARTMENT_SEARCH, param: param.getSearchParameter(), viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.getDistrictData(json: json)
            
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            if continueDetail{
                if current_page < numberOfpage {
                    continueDetail = false
                    current_page = current_page+1
                    
                    if isSearch {
                        searchDepertment()
                    }
                    else{
                        getDistrictDetail()
                    }
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if isFirst[indexPath.row] {
            return 190
        }
        else{
            return 150
        }
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
        else{
            cell.mapButton.isHidden = false
        }
        
        if isFirst[indexPath.row] {
            cell.headerLabel.isHidden = false
            cell.viewTopConstraint.constant = 39 // 191
        }
        else{
            cell.headerLabel.isHidden = true
            cell.viewTopConstraint.constant = 4 // 151
        }
        
        
        
        if isCenter[indexPath.row] {
            cell.headerLabel.text = "สำนักงานส่วนกลาง "+center_item+" แห่ง"
        }
        else{
            cell.headerLabel.text = "สำนักงานส่วนภูมิภาค "+String(Int(all_item))+" แห่ง"
            
        }
        
        let addressText = "ที่อยู่ : เลขที่ "+addrno[indexPath.row]+" "+building[indexPath.row]+" ตำบล "+district[indexPath.row]+" อำเภอ "+sub_district[indexPath.row]+" จังหวัด "+province[indexPath.row]
        let telText = "โทรศัพท์ : "+telephone[indexPath.row]
        
        
        cell.addressTextView.font = UIFont(name: "Quark-Bold", size: 15)
        cell.addressTextView.text = addressText+"\n"+telText
        cell.titleLabel.text = name[indexPath.row]
        cell.mapButton.addTarget(self, action: #selector(mapButton), for: .touchUpInside)
        cell.mapButton.tag = indexPath.row
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.telTextView(_:)))
        cell.addressTextView.delegate = self
        cell.addressTextView.tag = indexPath.row
        cell.addressTextView.isUserInteractionEnabled = true
        cell.addressTextView.addGestureRecognizer(tap)
        
        
        return cell
    }

    func telTextView(_ recognizer: UITapGestureRecognizer) {
        if (telephone[recognizer.view!.tag] != ""){
            print(telephone[recognizer.view!.tag])
            let numbers = telephone[recognizer.view!.tag]
            guard let number = URL(string: "telprompt://" + numbers) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                // Fallback on earlier versions
            }
        }
        
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
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
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
