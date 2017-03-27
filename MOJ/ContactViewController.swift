//
//  ContactViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class ContactViewController: UIViewController {
    @IBOutlet var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        
    }
    @IBAction func open(_ sender: Any) {
        
        openGoogleMap(lat: "13.7563", long: "100.5018")
    }
    
    
    func openGoogleMap(lat:String,long:String){
        
        let stringUrl = String.init(format: "http://maps.google.com/?q=%@,%@", lat,long)
        let url = URL(string: stringUrl)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }

    
    func setupMenuButton() {
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = self.view.frame.size.width - 50
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

