//
//  PsychoAdminViewController.swift
//  MOJ
//
//  Created by patcharat on 4/22/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class PsychoAdminViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let design = Design()
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var countRequestLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        
        
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! postAdminCell
        cell.backgroundColor = UIColor.clear
        design.roundView(view: cell.view, radius: 5)
        design.roundView(view: cell.confirmButton, radius: 5)
        design.roundView(view: cell.notConfirmButton, radius: 5)
        
        return cell
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
    
    
}


class postAdminCell: UITableViewCell {
    @IBOutlet var notConfirmButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var statusCodeLabel: UILabel!
    
    @IBOutlet var statusConfirmLabel: UILabel!
    @IBOutlet var statusDocLabel: UILabel!
    @IBOutlet var statusRequestLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
