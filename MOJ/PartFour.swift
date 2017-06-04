//
//  PartFour.swift
//  MOJ
//
//  Created by patcharat on 5/14/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PartFour:UITableViewController,UITextFieldDelegate{
    
    
    @IBOutlet var dataCell: UITableViewCell!
    //let notificationDataFormRenew4 = Notification.Name("DataFormRenew4")
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
    }
    
    @IBAction func addCellButton(_ sender: Any) {
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
