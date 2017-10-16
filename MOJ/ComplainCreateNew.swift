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
    
    var titles = 0
    var firstname = ""
    var lastname = ""
    var birthdate = ""
    var idnumber = ""
    var idbacknumber = ""
    
    @IBOutlet var detatilTextfiled: UITextField!
    @IBOutlet var titlesTextfile: UITextField!
    @IBOutlet var catagoryTextfield: UITextField!
    var pickerView: UIPickerView!
    let design = Design()
    let accountData = AccountData()
    let network = Network()
    let alertView = AlertView()
    let stringHelper = StringHelper()
    
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
        
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        catagoryTextfield.inputView = pickerView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return compltcatname.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return compltcatname[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        catagoryTextfield.text = compltcatname[row]
        selectCatagoryID = compltcatid[row]
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
