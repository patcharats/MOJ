//
//  PsychoServiceRenew.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class PsychoServiceRenew: UIViewController {
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var titleHeight: NSLayoutConstraint!
    @IBOutlet var titleLabelHeight: NSLayoutConstraint!
    
    var socialWorkData = SocialWorkData()
    var param = PsychoParameter()
    var network = Network()
    var alertView = AlertView()
    
    let titles = ["ชื่อและข้อมูลทะเบียน","ข้อมูลส่วนตัว","ข้อมูลการทำงาน","ข้อมูลการปฎิบัติหน้าที่เป็นผู้ทำหน้าที่\nนักจิตวิทยาหรือนักสังคมสงเคราะห์"]
    let notificationName = Notification.Name("clearTextfieldRenew")
    let notificationDataFormRenew1 = Notification.Name("DataFormRenew1")
    let notificationDataFormRenew2 = Notification.Name("DataFormRenew2")
    let notificationDataFormRenew3 = Notification.Name("DataFormRenew3")
    let notificationDataFormRenew4 = Notification.Name("DataFormRenew4")
    
    
    var registrationExpireTextField:String = ""
    var registrationDateTextField:String = ""
    var registrationNumberTextField:String = ""
    var registrationlastNameTextField:String = ""
    var registrationfirstNameTextField:String = ""
    
    var IDTypeTextField:String = ""
    var IDNumberTextField:String = ""
    var IDExpireTextField:String = ""
    var IDDateTextField:String = ""
    var IDByTextField:String = ""
    var titleNameTextField:String = ""
    var firstNameTextField:String = ""
    var lastNameTextField:String = ""
    var birthdateTextField:String = ""
    var maritalStatusTextField:String = ""
    var religionTextField:String = ""
    var nationalityTextField:String = ""
    var houseNoTextField:String = ""
    var villageNoTextField:String = ""
    var streetTextField:String = ""
    var roadTextField:String = ""
    var subDistrictTextField:String = ""
    var districtTextField:String = ""
    var provinceTextField:String = ""
    var postalCodeTextField:String = ""
    var houseNoTextField2:String = ""
    var villageNoTextField2:String = ""
    var streetTextField2:String = ""
    var roadTextField2:String = ""
    var subDistrictTextField2:String = ""
    var districtTextField2:String = ""
    var provinceTextField2:String = ""
    var postalCodeTextField2:String = ""
    var phoneTextField:String = ""
    var mobilePhoneTextField:String = ""
    var faxTextField:String = ""
    var emailTextField:String = ""
    
    var occupationTexField:String = ""
    var otherTexField:String = ""
    var governmentTexField:String = ""
    var positionTexField:String = ""
    var levelTexField:String = ""
    var houseNoTextField3:String = ""
    var villageNoTextField3:String = ""
    var streetTextField3:String = ""
    var roadTextField3:String = ""
    var subDistrictTextField3:String = ""
    var districtTextField3:String = ""
    var provinceTextField3:String = ""
    var postalCodeTextField3:String = ""
    var phoneTextField2:String = ""
    var mobilePhoneTextField2:String = ""
    var faxTextField2:String = ""
    var emailTextField2:String = ""
    var province1TextField:String = ""
    var province2TextField:String = ""
    var province3TextField:String = ""
    
    var SelectCardID:Int = 0
    var SelectMaritalStatusID:Int = 0
    var SelectTitleID:Int = 0
    var SelectReligionID:Int = 0
    var SelectProvinceID:Int = 0
    var SelectAmphurID:Int = 0
    var SelectDistictID:Int = 0
    var SelectProvinceID2:Int = 0
    var SelectAmphurID2:Int = 0
    var SelectDistictID2:Int = 0
    
    var SelectOccupationOptionID:Int = 0
    var SelectOrgProvinceID:Int = 0
    var SelectOrgAmphurID:Int = 0
    var SelectOrgDistrictID:Int = 0
    
    var SelectProvince1:Int = 0
    var SelectProvince2:Int = 0
    var SelectProvince3:Int = 0
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
            tutorialPageViewController?.typeViewController = 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(PsychoServiceCreateNew.didChangePageControlValue), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataFormRenew1(_:)), name: notificationDataFormRenew1, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataFormRenew2(_:)), name: notificationDataFormRenew2, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataFormRenew3(_:)), name: notificationDataFormRenew3, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataFormRenew4(_:)), name: notificationDataFormRenew4, object: nil)
        
    }
    
    
    func getDataFormRenew1(_ notification: NSNotification) {
        registrationExpireTextField = notification.userInfo?["registrationExpireTextField"] as! String
        registrationDateTextField = notification.userInfo?["registrationDateTextField"] as! String
        registrationNumberTextField = notification.userInfo?["registrationNumberTextField"] as! String
        registrationlastNameTextField = notification.userInfo?["registrationlastNameTextField"] as! String
        registrationfirstNameTextField = notification.userInfo?["registrationfirstNameTextField"] as! String
    }
    
    func getDataFormRenew2(_ notification: NSNotification) {
        IDTypeTextField = notification.userInfo?["IDTypeTextField"] as! String
        IDNumberTextField = notification.userInfo?["IDNumberTextField"] as! String
        IDExpireTextField = notification.userInfo?["IDExpireTextField"] as! String
        IDDateTextField = notification.userInfo?["IDDateTextField"] as! String
        IDByTextField = notification.userInfo?["IDByTextField"] as! String
        
        titleNameTextField = notification.userInfo?["titleNameTextField"] as! String
        firstNameTextField = notification.userInfo?["firstNameTextField"] as! String
        lastNameTextField = notification.userInfo?["lastNameTextField"] as! String
        birthdateTextField = notification.userInfo?["birthdateTextField"] as! String
        maritalStatusTextField = notification.userInfo?["maritalStatusTextField"] as! String
        religionTextField = notification.userInfo?["religionTextField"] as! String
        nationalityTextField = notification.userInfo?["nationalityTextField"] as! String
        
        houseNoTextField = notification.userInfo?["houseNoTextField"] as! String
        villageNoTextField = notification.userInfo?["villageNoTextField"] as! String
        streetTextField = notification.userInfo?["streetTextField"] as! String
        roadTextField = notification.userInfo?["roadTextField"] as! String
        subDistrictTextField = notification.userInfo?["subDistrictTextField"] as! String
        districtTextField = notification.userInfo?["districtTextField"] as! String
        provinceTextField = notification.userInfo?["provinceTextField"] as! String
        postalCodeTextField = notification.userInfo?["postalCodeTextField"] as! String
        
        houseNoTextField2 = notification.userInfo?["houseNoTextField2"] as! String
        villageNoTextField2 = notification.userInfo?["villageNoTextField2"] as! String
        streetTextField2 = notification.userInfo?["streetTextField2"] as! String
        roadTextField2 = notification.userInfo?["roadTextField2"] as! String
        subDistrictTextField2 = notification.userInfo?["subDistrictTextField2"] as! String
        districtTextField2 = notification.userInfo?["districtTextField2"] as! String
        provinceTextField2 = notification.userInfo?["provinceTextField2"] as! String
        postalCodeTextField2 = notification.userInfo?["postalCodeTextField2"] as! String
        
        phoneTextField = notification.userInfo?["phoneTextField"] as! String
        mobilePhoneTextField = notification.userInfo?["mobilePhoneTextField"] as! String
        faxTextField = notification.userInfo?["faxTextField"] as! String
        emailTextField = notification.userInfo?["emailTextField"] as! String
        
        SelectCardID = notification.userInfo?["SelectCardID"] as! Int
        SelectTitleID = notification.userInfo?["SelectTitleID"] as! Int
        SelectMaritalStatusID = notification.userInfo?["SelectMaritalStatusID"] as! Int
        SelectReligionID = notification.userInfo?["SelectReligionID"] as! Int
        SelectProvinceID = notification.userInfo?["SelectProvinceID"] as! Int
        SelectAmphurID = notification.userInfo?["SelectAmphurID"] as! Int
        SelectDistictID = notification.userInfo?["SelectDistictID"] as! Int
        SelectProvinceID2 = notification.userInfo?["SelectProvinceID2"] as! Int
        SelectAmphurID2 = notification.userInfo?["SelectAmphurID2"] as! Int
        SelectDistictID2 = notification.userInfo?["SelectDistictID2"] as! Int
        
    }
    
    
    func getDataFormRenew3(_ notification: NSNotification) {
        occupationTexField = notification.userInfo?["occupationTexField"] as! String
        otherTexField = notification.userInfo?["otherTexField"] as! String
        governmentTexField = notification.userInfo?["governmentTexField"] as! String
        positionTexField = notification.userInfo?["positionTexField"] as! String
        levelTexField = notification.userInfo?["levelTexField"] as! String
        houseNoTextField3 = notification.userInfo?["houseNoTextField"] as! String
        villageNoTextField3 = notification.userInfo?["villageNoTextField"] as! String
        streetTextField3 = notification.userInfo?["streetTextField"] as! String
        roadTextField3 = notification.userInfo?["roadTextField"] as! String
        subDistrictTextField3 = notification.userInfo?["subDistrictTextField"] as! String
        districtTextField3 = notification.userInfo?["districtTextField"] as! String
        provinceTextField3 = notification.userInfo?["provinceTextField"] as! String
        postalCodeTextField3 = notification.userInfo?["postalCodeTextField"] as! String
        phoneTextField2 = notification.userInfo?["phoneTextField"] as! String
        mobilePhoneTextField2 = notification.userInfo?["mobilePhoneTextField"] as! String
        faxTextField2 = notification.userInfo?["faxTextField"] as! String
        emailTextField2 = notification.userInfo?["emailTextField"] as! String
        
        SelectOccupationOptionID = notification.userInfo?["SelectOccupationOptionID"] as! Int
        SelectOrgProvinceID = notification.userInfo?["SelectOrgProvinceID"] as! Int
        SelectOrgAmphurID = notification.userInfo?["SelectOrgAmphurID"] as! Int
        SelectOrgDistrictID = notification.userInfo?["SelectOrgDistrictID"] as! Int
    }
    
    
    func getDataFormRenew4(_ notification: NSNotification) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clearTextfield(_ sender: Any) {
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func renewButton(_ sender: Any) {
        print("renew")
        param.addr1moo = villageNoTextField
        param.addr1no = houseNoTextField
        param.addr1road = roadTextField
        param.addr1soi = streetTextField
        param.addr1telephn = ""
        param.addr1zip = postalCodeTextField
        param.addr2email = emailTextField
        param.addr2fax = faxTextField
        param.addr2mobile = mobilePhoneTextField
        param.addr2moo = villageNoTextField2
        param.addr2no = houseNoTextField2
        param.addr2road = roadTextField2
        param.addr2soi = streetTextField2
        param.addr2telephn = phoneTextField
        param.addr2zip = postalCodeTextField2
        param.addrorgmoo = villageNoTextField3
        param.addrorgno = houseNoTextField3
        param.addrorgsoi = streetTextField3
        param.addrorroad = roadTextField3
        param.addrorzip = postalCodeTextField3
        
        param.firstname = firstNameTextField
        param.idcardno = IDNumberTextField
        param.issueby = IDByTextField
        param.issuedate = IDDateTextField
        param.expiredate = IDExpireTextField
        param.lastname = lastNameTextField
        param.nationality = nationalityTextField
        
        param.occlevel = levelTexField
        param.occorgname = occupationTexField
        param.occother = otherTexField
        param.occposition = positionTexField
        param.orgadfax = faxTextField2
        param.orgadmobile = mobilePhoneTextField2
        param.orgadphone = phoneTextField2
        // param.orgademail = emailTextField2
        
        param.notapprove = ""
        param.approvedate = ""
        param.checkdoc = ""
        param.confirmdata = ""
        param.postponestatus = ""
        param.provlatedoc = ""
        param.reqstatus = ""
        param.requestdate = ""
        param.requestid = ""
        param.requestno = ""
        param.requesttype = ""
        param.studyother = ""
        
        
        param.province1id = SelectProvince1
        param.province2id = SelectProvince2
        param.province3id = SelectProvince3
        param.province1 = province1TextField
        param.province2 = province2TextField
        param.province3 = province3TextField
        
        param.addr1amphurid = SelectAmphurID
        param.addr1provinceid = SelectProvinceID
        param.addr1tumbonid = SelectDistictID
        param.addr2amphurid = SelectAmphurID2
        param.addr2provinceid = SelectProvinceID2
        param.addr2tumbonid = SelectDistictID2
        param.addroramphurid = SelectOrgAmphurID
        param.addrorprovinceid = SelectOrgProvinceID
        param.addrortumbonid = SelectOrgDistrictID
        param.cardtypeid = SelectCardID
        param.maritalstatusid = SelectMaritalStatusID
        param.occupationid = SelectOccupationOptionID
        param.prenameid = SelectTitleID
        param.religionid = SelectReligionID
        
        network.post(name: network.API_SOCIAL_WORK_NEW_REQUEST, param: param.getReNewPsychoParameter(), viewController: self, completionHandler: {
            (json : Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            
            if(Code == "00000"){
                self.alertView.alertWithAction(title:"", message: self.alertView.ALERT_RENEW_SUCCESS, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                    (button : Bool) in
                    if button {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                });
            }
            else{
                self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
}



extension PsychoServiceRenew: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        titleLabel.text = titles[index]
        
        if index == 3 {
            titleHeight.constant = 50
            titleLabelHeight.constant = 57
        }
        else{
            titleHeight.constant = 34
            titleLabelHeight.constant = 40
            
        }
    }
    
}
