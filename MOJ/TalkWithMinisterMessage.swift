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
    @IBOutlet var checkPublicButton: UIButton!
    @IBOutlet var subjectTextField: UITextField!
    @IBOutlet var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design.roundView(view: subjectTextField, radius: 10)
        design.roundView(view: messageTextField, radius: 10)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SendMessage(_ sender: Any) {
    }

    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    
}
