//
//  FileEvidence.swift
//  MOJ
//
//  Created by patcharat on 4/24/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class FileEvidence:UITableViewController{
    var socialWorkData = SocialWorkData()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let readOnly = socialWorkData.isReadOnly()
        
        if readOnly {
            socialWorkData.getSocialWorkData(json: socialWorkData.getData())
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)
        }
        else{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
        }
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
