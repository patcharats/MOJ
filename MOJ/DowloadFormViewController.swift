//
//  DowloadFormViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class DowloadFormViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let design = Design()
    let network = Network()
    let stringHelper = StringHelper()
    let PDF_DETAIL_VIEW_CONTROLLER = "PdfDetailViewController"
    var pdfUrl:String!
    let KEY_DOC_DATA = "data"
    let KEY_DOC_ID = "docid"
    let KEY_DOC_URL = "docurl"
    let KEY_DOWNLOAD = "downld"
    let KEY_LAST_UPDATE = "lastupd"
    let KEY_DOC_NAME = "name"
    let KEY_DOC_SHARE_URL = "shareurl"
    
    var docid:[String] = []
    var docurl:[String] = []
    var downld:[String] = []
    var lastupd:[String] = []
    var name:[String] = []
    var shareurl:[String] = []
    
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var openButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        network.get(name: network.API_DOCUMENT, param:"", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
            self.docid = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_DOC_ID].stringValue})
            self.docurl = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_DOC_URL].stringValue})
            self.downld = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_DOWNLOAD].stringValue})
            self.lastupd = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_LAST_UPDATE].stringValue})
            self.name = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_DOC_NAME].stringValue})
            self.shareurl = jsonSwifty[self.KEY_DOC_DATA].arrayValue.map({$0[self.KEY_DOC_SHARE_URL].stringValue})
            
            self.tableView.reloadData()
        })
    }

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docid.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! downloadFormCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        design.roundView(view: cell.downloadButton, radius: 5)
        design.roundView(view: cell.shareButton, radius: 5)
        
        
        cell.titleLabel.text = name[indexPath.row]
        cell.dateLabel.text = stringHelper.getDatefromString(dateString: lastupd[indexPath.row])
        cell.downloadLabel.text = downld[indexPath.row]+" ดาวน์โหลด"
        cell.downloadButton.addTarget(self, action: #selector(downloadButton), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(shareButton), for: .touchUpInside)
        cell.downloadButton.tag = indexPath.row
        cell.shareButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRemotePDFDocument(remotePDFDocumentURLPath: docurl[indexPath.row],title:name[indexPath.row])
    }
    
    func downloadButton(sender: UIButton!) {
        
        let url = URL(string: docurl[sender.tag])
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
        network.get(name: network.API_DOCUMENT, param:docid[sender.tag], viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            let jsonSwifty = JSON(json)
        })
    }
    
    func shareButton(sender: UIButton!) {
        
        let url = NSURL(string: shareurl[sender.tag])
        
        let activityViewController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        self.present(activityViewController, animated: true, completion: nil)
        

    }


    
    func setupMenuButton() {
        if revealViewController() != nil {
            let percent = self.view.frame.size.width - ((self.view.frame.size.width * 30)/100)
            revealViewController().rearViewRevealWidth = percent
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
    
    
    // MARK: - PDF
    

    func showRemotePDFDocument(remotePDFDocumentURLPath:String,title:String) {
        //let remote = "http://www.pdf995.com/samples/pdf.pdf"
        if let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath),
            let doc = document(remotePDFDocumentURL) {
            showDocument(doc, title: title)
        } else {
            print("Document named \(remotePDFDocumentURLPath) not found")
        }
    }

    fileprivate func document(_ remoteURL: URL) -> PDFDocument? {
        return PDFDocument(url: remoteURL)
    }

    fileprivate func showDocument(_ document: PDFDocument ,title:String) {
        let controller = PDFViewController.createNew(with: document, title: title)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


class downloadFormCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

