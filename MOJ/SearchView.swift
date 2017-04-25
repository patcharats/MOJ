//
//  SearchView.swift
//  MOJ
//
//  Created by patcharat on 4/22/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class SearchView: UIView {
    
    let design = Design()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        design.roundView(view: self, radius: 5)
        //custom logic goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class SearchTextfield:UITextField{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearButtonMode = .whileEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
