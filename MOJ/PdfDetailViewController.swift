//
//  PdfDetailViewController.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class PdfDetailViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    @IBAction func backAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

