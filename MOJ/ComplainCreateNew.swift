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
class ComplainCreateNew: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
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
    var compltcatid:[Int] = []
    var compltcatname:[String] = []
    var param = ComplaintParameter()
    
    var imagePicker = UIImagePickerController()
    

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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
          
//            imageView.image = image
           self.imageButton.setImage(image, for: UIControlState.normal)
            
        })
        
    
    }
    
    @IBAction func imageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
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
                (JSON : Any,Code:String,Message:String) in
            
                if(Code == "00000"){
                    self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                    
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    
                }
                else{
                    self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                    
                }
                
                
                
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
    
   
    
}
