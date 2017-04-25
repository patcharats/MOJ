//
//  NewDetailViewContoller.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class NewDetailViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var newsTextview: UITextView!
    var stringHelper = StringHelper()
    var selectNewsUrl:String = ""
    var selectTitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.backgroundColor = UIColor.clear
        if stringHelper.verifyUrl(urlString: selectNewsUrl) {
            
            setupWebView()
        }
        else{
            newsTextview.text = selectTitle
            newsTextview.font = UIFont(name: "Quark-Bold", size: 15)
        }
        
    }
    @IBAction func backAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        webView.scrollView.contentInset = UIEdgeInsets.zero;
    }
    
    func setupWebView(){
        webView.delegate = self
        if let url = URL(string: selectNewsUrl) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

