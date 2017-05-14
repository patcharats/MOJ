//
//  PsychoParameter.swift
//  MOJ
//
//  Created by patcharat on 5/14/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import Alamofire

class PsychoParameter: NSObject {
    
    let stringHelper = StringHelper()
    let accountData = AccountData()
    var search_key:String = ""
    
    func getSearchParameter()-> Parameters{
        
        let parameters: Parameters = [
            "data": [
                "search_key": search_key
            ]
        ]
        return parameters
    }

}
