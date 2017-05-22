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
    var typeNew:Int = 0
    var TYPE_NEWS:String = "ข่าวสาร"
    var TYPE_NOTICES:String = "ประกาศจัดซื้อจัดจ้าง"
    var TYPE_JOB:String = "รับสมัครงาน"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch typeNew {
        case 1:
            self.title = TYPE_NEWS
            break
        case 2:
            self.title = TYPE_NOTICES
            break
        case 3:
            self.title = TYPE_JOB
            break
        default:
            self.title = TYPE_NEWS
            break
        }
        
        webView.backgroundColor = UIColor.clear
        if stringHelper.verifyUrl(urlString: selectNewsUrl) {
            
            setupWebView()
            newsTextview.isHidden = true
            webView.isHidden = false
        }
        else{
            webView.isHidden = true
            newsTextview.isHidden = false
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

