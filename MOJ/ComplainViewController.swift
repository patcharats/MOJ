//
//  ComplainViewController.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit

class ComplainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let design = Design()
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! complainCell
        cell.backgroundColor = UIColor.clear
        design.roundViewTop(view: cell.titleLabel, radius: 5)
        design.roundViewBottom(view: cell.view, radius: 5)
        design.roundView(view: cell.proceedLabel, radius: 5)
        design.roundView(view: cell.succeedLabel, radius: 5)
        
        let processStatus = true
        if processStatus {
            cell.proceedLabel.isHidden = true
            cell.succeedLabel.isHidden = false
        }
        else{
            cell.proceedLabel.isHidden = false
            cell.succeedLabel.isHidden = true
        }
        
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

class complainCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var complainCodeLabel: UILabel!
    @IBOutlet weak var proceedLabel: UILabel!
    @IBOutlet weak var succeedLabel: UILabel!

    @IBOutlet var alertImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
