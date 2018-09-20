//
//  ComplainCreateNew.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class ComplainCreateNew: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UITextFieldDelegate{
    
    let CATAGORIE_TYPE = 0
    let PROVINCE_NAME = 1
    let AMPHUR_NAME = 2
    let DISTRICT_NAME = 3
    
    var provinceID:[Int] = []
    var provinceName:[String] = []
    
    var amphurID:[Int] = []
    var amphurName:[String] = []
    
    var districtID:[Int] = []
    var districtName:[String] = []
    
    var zipcode:[String] = []
    
    var pickerView1:UIPickerView!
    var pickerView2:UIPickerView!
    var pickerView3:UIPickerView!
    
    var SelectProvinceID:Int = 0
    var SelectAmphurID:Int = 0
    var SelectDistictID:Int = 0
    var address:String? = ""
    var address_tumbon:String? = ""
    var address_amphur:String? = ""
    var address_province:String? = ""
    var address_zip:String? = ""
    
    
    var titles = 0
    var firstname = ""
    var lastname = ""
    var birthdate = ""
    var idnumber = ""
    var idbacknumber = ""
    
    
    @IBOutlet var addressTextfield: UITextField!
    
    @IBOutlet var addressProvinceTextfield: UITextField!
    @IBOutlet var addressAmphurTextfield: UITextField!
    @IBOutlet var addressTambonTextfield: UITextField!
    @IBOutlet var addressZipTextfield: UITextField!
    
    
    @IBOutlet var detatilTextfiled: UITextField!
    @IBOutlet var titlesTextfile: UITextField!
    @IBOutlet var catagoryTextfield: UITextField!
    var pickerView: UIPickerView!
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    let configData = ConfigData()
    
    @IBOutlet var sendButton: UIButton!
    var selectCatagoryID = 0
    let KEY_COMPLAINT_DATA = "data"
    let KEY_COMPLAINT_GUIDE_ID = "compltcatid"
    let KEY_COMPLAINT_GUIDE_NAME = "compltcatname"
    let KEY_COMPLAINT_ID = "cmpltid"
    let KEY_COMPLAINT_USER_ID = "cmpltuserid"
    var compltcatid:[Int] = []
    var compltcatname:[String] = []
    var cmpltid :String = ""
    var cmpltuserid :String = ""
    var param = ComplaintParameter()
    var imageArray:[UIImage] = []
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var imageButton: UIButton!
    var subject = ""
    var detail = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        network.get(name: network.API_COMPLAINT_GUIDE, param:"", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.compltcatid = jsonSwifty[self.KEY_COMPLAINT_DATA].arrayValue.map({$0[self.KEY_COMPLAINT_GUIDE_ID].intValue})
            self.compltcatname = jsonSwifty[self.KEY_COMPLAINT_DATA].arrayValue.map({$0[self.KEY_COMPLAINT_GUIDE_NAME].stringValue})
            
        })
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        catagoryTextfield.delegate = self
        
        address = accountData.getAddress()
        address_province = accountData.getAddressProvince()
        address_amphur = accountData.getAddressAmphur()
        address_tumbon = accountData.getAddressTambon()
        address_zip = accountData.getAddressZip()
        SelectProvinceID = Int(accountData.getAddressProvinceID())!
        SelectAmphurID = Int(accountData.getAddressAmphurID())!
        SelectDistictID = Int(accountData.getAddressTambonID())!
        
        
        addressTextfield.text = address
        addressProvinceTextfield.text = address_province
        addressAmphurTextfield.text = address_amphur
        addressTambonTextfield.text = address_tumbon
        addressZipTextfield.text = address_zip
        
        getConfigData()
        setPickerView()

    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == catagoryTextfield{
            catagoryTextfield.text = compltcatname[0]
            selectCatagoryID = compltcatid[0]
        }
    }
    
    
    @IBAction func imageButton(_ sender: Any) {
        
        if (imageArray.count == 5){
            alertView.alert(title: alertView.INPUT_LIMIT_5_IMAGES, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            alertController()
        }
        
        
    }
    
    
    func alertController(){
        let alertController = UIAlertController(title: "เลือกรูปจาก", message: "", preferredStyle: .alert)
        
        let oneAction = UIAlertAction(title: "กล้อง", style: .default) { _ in
            
            self.imagePickerCamera()
        }
        let twoAction = UIAlertAction(title: "อัลบั้ม", style: .default) { _ in
            self.imagePickerAlbum()
        }
        let cancelAction = UIAlertAction(title: "ยกเลิก", style: .cancel) { _ in }
        
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    func imagePickerAlbum(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerCamera(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageArray.insert(chosenImage, at: 0)
        self.collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil);
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        let catagory = catagoryTextfield.text
        subject = titlesTextfile.text!
        detail = detatilTextfiled.text!
        
        if (catagory?.isEmpty)! || (subject.isEmpty) || (detail.isEmpty) {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            
            param.cmpltservguide = selectCatagoryID
            param.cmpltcontent = detail
            param.cmpltsubject = subject
            
            param.address = address
            param.address_tumbon = address_tumbon
            param.address_amphur = address_amphur
            param.address_province = address_province
            param.address_zip = address_zip
            
            network.post(name: network.API_COMPLAINT_POST, param: param.getCreateComplaintParameter(), viewController: self, completionHandler: {
                (json : Any,Code:String,Message:String) in
                let jsonSwifty = JSON(json)
                
                if(Code == "00000"){
                    self.cmpltid = jsonSwifty[self.KEY_COMPLAINT_DATA][self.KEY_COMPLAINT_ID].stringValue
                    self.cmpltuserid = jsonSwifty[self.KEY_COMPLAINT_DATA][self.KEY_COMPLAINT_USER_ID].stringValue
                    
                    print(self.cmpltid)
                    print(self.cmpltuserid)
                    
                    if !self.imageArray.isEmpty{
                        self.uploadImage()
                    }
                    self.alertView.alertWithAction(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
                        (button : Bool) in
                        if button {
                            self.popView()
                        }
                    });
                }
                else{
                    self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                    
                }
                
                
                
            })
            
        }
    
    }

    
    func uploadImage(){
        for (index, element) in self.imageArray.enumerated() {
            let parameters = [
                "cmpltid": cmpltid,
                "cmpltuserid": cmpltuserid]
            
            
            network.postImage(name: network.API_COMPLAINT_POST_IMAGE, param: parameters as NSDictionary, image: element, viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                if(Code == "00000"){
                        print("Item \(index): \(element)")
                }
                
                //self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
            })
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func popView(){
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! imageCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.imageView.image = imageArray[indexPath.row]
        cell.removeImage.tag = indexPath.row
        cell.removeImage.addTarget(self, action: #selector(removeImage), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imageArray.count
    }
    
    
    func removeImage(sender: UIButton!) {
        imageArray.remove(at:sender.tag)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    ///////// PICKER VIEW
    
    func getAmphur(provinceID:Int){
        let param = String(provinceID)
        self.network.get(name: self.network.API_CONFIG_AMPHUR, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigAmphur(json: json)
            self.amphurID = self.configData.getAmphurID()
            self.amphurName = self.configData.getAmphurName()
            
            self.amphurID.insert(0, at: 0)
            self.amphurName.insert("", at: 0)
            
        })
    }
    
    func getTambon(amphurID:Int){
        let param = String(amphurID)
        self.network.get(name: self.network.API_CONFIG_DISTRICT, param:param, viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigDistrict(json: json)
            self.districtID = self.configData.getDistrictID()
            self.districtName = self.configData.getDistrictName()
            self.zipcode = self.configData.getDistrictZipCode()
            
            self.districtID.insert(0, at: 0)
            self.districtName.insert("", at: 0)
            self.zipcode.insert("", at: 0)
        })
    }
    
    func getConfigData(){
        provinceID = configData.getProvinceID()
        provinceName = configData.getProvinceName()
        amphurID = configData.getAmphurID()
        amphurName = configData.getAmphurName()
        
        provinceID.insert(0, at: 0)
        provinceName.insert("", at: 0)
        
        districtID = configData.getDistrictID()
        districtName = configData.getDistrictName()
        
    }
    func setPickerView(){
        pickerView = UIPickerView()
        pickerView1 = UIPickerView()
        pickerView2 = UIPickerView()
        pickerView3 = UIPickerView()
        
        pickerView.dataSource = self
        pickerView1.dataSource = self
        pickerView2.dataSource = self
        pickerView3.dataSource = self
        
        pickerView.delegate = self
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        
        pickerView.tag = CATAGORIE_TYPE
        pickerView1.tag = PROVINCE_NAME
        pickerView2.tag = AMPHUR_NAME
        pickerView3.tag = DISTRICT_NAME
        
        catagoryTextfield.inputView = pickerView
        addressProvinceTextfield.inputView = pickerView1
        addressAmphurTextfield.inputView = pickerView2
        addressTambonTextfield.inputView = pickerView3
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case CATAGORIE_TYPE:
            return compltcatname.count
        case PROVINCE_NAME:
            return provinceName.count
        case DISTRICT_NAME:
            return districtName.count
        case AMPHUR_NAME:
            return amphurName.count
        default:
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case CATAGORIE_TYPE:
            return compltcatname[row]
        case PROVINCE_NAME:
            return provinceName[row]
        case DISTRICT_NAME:
            return districtName[row]
        case AMPHUR_NAME:
            return amphurName[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch pickerView.tag {
        case CATAGORIE_TYPE:
            catagoryTextfield.text = compltcatname[row]
            selectCatagoryID = compltcatid[row]
        case PROVINCE_NAME:
            addressProvinceTextfield.text = provinceName[row]
            getAmphur(provinceID: provinceID[row])
            SelectProvinceID = provinceID[row]
            
        case AMPHUR_NAME:
            addressAmphurTextfield.text = amphurName[row]
            getTambon(amphurID: amphurID[row])
            SelectAmphurID = amphurID[row]
            
        case DISTRICT_NAME:
            addressTambonTextfield.text = districtName[row]
            addressZipTextfield.text = zipcode[row]
            SelectDistictID = districtID[row]
            
        default:
            print("fail")
        }
        
    }
    
    
}


class imageCollectionViewCell: UICollectionViewCell {
    
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
