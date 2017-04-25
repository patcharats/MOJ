//
//  PsychoNavigationController.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class PsychoNavigationController: UINavigationController {
    let account = AccountData()
    let PSYCHO_ADMIN_VIEW = "PsychoAdmin"
    let PSYCHO_USER_VIEW = "PsychoUser"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if account.isAdmin() {
            performSegue(withIdentifier: PSYCHO_ADMIN_VIEW, sender: nil)
        }
        else{
            performSegue(withIdentifier: PSYCHO_USER_VIEW, sender: nil)
        }

    }

}
