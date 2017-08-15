//
//  DepartmentParameter.swift
//  MOJ
//
//  Created by patcharat on 8/15/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import Alamofire
class DepartmentParameter: NSObject {

    var q:String = ""
    var type:String = ""
    var page:Int = 0
    var depcenter:Bool = false
    
    func getSearchParameter()-> Parameters{
        let parameters: Parameters = [
            "data": [
                "q": q,
                "type": type,
                "page": page,
                "depcenter":depcenter
            ]
        ]
        return parameters
    }
    
    
    
}
