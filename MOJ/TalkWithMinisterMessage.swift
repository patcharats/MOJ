//
//  TalkWithMinisterMessage.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class TalkWithMiniterMessage: UIViewController{
    let design = Design()
    let network = Network()
    let param = ContactsParameter()
    let alertView = AlertView()
    
    @IBOutlet var checkPublicButton: UIButton!
    @IBOutlet var subjectTextField: UITextField!
    @IBOutlet var messageTextField: UITextField!
    
    let IMAGE_CHECK_BOX_TRUE = "checkbox_on"
    let IMAGE_CHECK_BOX_FALSE = "checkbox_off"
    var isCheckBox = false
    var subject = ""
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design.roundView(view: subjectTextField, radius: 10)
        design.roundView(view: messageTextField, radius: 10)
        
        checkPublicButton.setImage(UIImage (named: IMAGE_CHECK_BOX_FALSE), for: UIControlState.normal)
    }
    

    
    @IBAction func publicButton(_ sender: Any) {
        SetCheckBox()
    }

    func SetCheckBox(){
        
        var imageName = ""
        
        if isCheckBox {
            isCheckBox = false
            imageName = IMAGE_CHECK_BOX_FALSE
        }
        else{
            isCheckBox = true
            imageName = IMAGE_CHECK_BOX_TRUE
        }
        
        checkPublicButton.setImage(UIImage (named: imageName), for: UIControlState.normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SendMessage(_ sender: Any) {
        
        subject = subjectTextField.text!
        message = messageTextField.text!
        
        if subject.isEmpty || message.isEmpty {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            
            param.contact_subject = subject
            param.contact_body = message
            
            network.post(name: network.API_CONTACTS_NEW_POST, param: param.getNewPostParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    
                }
                else{
                    self.alertView.alert(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self)
                }
                
            })
        }
        
        
    }

    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    
}
