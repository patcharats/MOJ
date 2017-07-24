//
//  TalkWithMinisterMessage.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class TalkWithMiniterMessage: UIViewController,UITextViewDelegate{
    let design = Design()
    let network = Network()
    let param = ContactsParameter()
    let alertView = AlertView()
    
    @IBOutlet var subjectTextField: UITextField!
    @IBOutlet var messageTextField: UITextField!
    
    @IBOutlet var messageTextView: UITextView!
    let IMAGE_CHECK_BOX_TRUE = "checkbox_on"
    let IMAGE_CHECK_BOX_FALSE = "checkbox_off"
    var isCheckBox = false
    var subject = ""
    var message = ""
    var isPublicStatus:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        design.roundView(view: subjectTextField, radius: 10)
        design.roundView(view: messageTextView, radius: 10)
        messageTextView.delegate = self
        messageTextView.text = "* ข้อความ"
        messageTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "* ข้อความ"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SendMessage(_ sender: Any) {
        
        subject = subjectTextField.text!
        message = messageTextView.text!
        
        if subject.isEmpty || message.isEmpty {
            alertView.alert(title: alertView.ALERT_NULL_INPUT, message: "", buttonTitle: alertView.ALERT_OK, controller: self)
        }
        else{
            
            param.contact_subject = subject
            param.contact_body = message
            param.isPublicStatus = isPublicStatus
            network.post(name: network.API_CONTACTS_NEW_POST, param: param.getNewPostParameter(), viewController: self, completionHandler: {
                (JSON : Any,Code:String,Message:String) in
                
                if(Code == "00000"){
                    self.alertView.alertWithAction(title:"", message: Message, buttonTitle: self.alertView.ALERT_OK, controller: self, completionHandler: {
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
        
        
    }

    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    
}
