//
//  OtherDetail.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class OtherDetail:UITableViewController{
    var socialWorkData = SocialWorkData()
    @IBOutlet var trainingTextField: UITextField!
    @IBOutlet var trainingByTextField: UITextField!
    @IBOutlet var trainingDateTextField: UITextField!
    
    @IBOutlet var lastExperienceTextField: UITextField!
    @IBOutlet var experienceStartTextField: UITextField!
    @IBOutlet var experienceEndField: UITextField!
    @IBOutlet var detailExperienceTextField: UITextField!
    
    @IBOutlet var province1TextField: UITextField!
    @IBOutlet var province2TextField: UITextField!
    @IBOutlet var province3TextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0 // your number of cell here
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}
