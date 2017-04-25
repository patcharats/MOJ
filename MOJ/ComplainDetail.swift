//
//  ComplainDetail.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class ComplainDetail: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    let design = Design()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }
    

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 364
        }
        else{
            return 174
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! complainDetailCell
        cell.backgroundColor = UIColor.clear
        design.roundViewTop(view: cell.ryplyTitleLabel, radius: 5)
        design.roundViewBottom(view: cell.viewRyply, radius: 5)
        design.roundViewTop(view: cell.titleLabel, radius: 5)
        design.roundViewBottom(view: cell.viewDetail, radius: 5)
        design.roundView(view: cell.proceedLabel, radius: 5)
        design.roundView(view: cell.succeedLabel, radius: 5)
        cell.detailTextView.font = UIFont(name: "Quark-Bold", size: 15)
        
        if indexPath.row == 0 {
            
            cell.viewDetail.isHidden = false
            cell.viewRyply.isHidden = true
        }
        else{

            cell.viewDetail.isHidden = true
            cell.viewRyply.isHidden = false
        }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}


class complainDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var complainCodeLabel: UILabel!
    @IBOutlet weak var proceedLabel: UILabel!
    @IBOutlet weak var succeedLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    
    @IBOutlet weak var viewRyply: UIView!
    @IBOutlet weak var ryplyTitleLabel: UILabel!
    @IBOutlet weak var ryplyDetailLabel: UILabel!
    @IBOutlet weak var ryplyDateLabel: UILabel!
    @IBOutlet weak var replyComplainCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
