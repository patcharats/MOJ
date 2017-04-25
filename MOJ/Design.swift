//
//  Design.swift
//  MOJ
//
//  Created by CBK-Admin on 4/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class Design: NSObject {
    
    func roundViewTop(view:UIView,radius:CGFloat){
        view.clipsToBounds = true
        view.layoutIfNeeded()
        let mask = UIBezierPath(roundedRect: view.bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii:CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = mask.cgPath
        view.layer.mask = maskLayer
    }
    
    func roundViewBottom(view:UIView,radius:CGFloat){
        view.clipsToBounds = true
        view.layoutIfNeeded()
        let mask = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.bottomLeft , .bottomRight],
                                cornerRadii:CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = mask.cgPath
        view.layer.mask = maskLayer
    }

    
    func roundView(view:UIView,radius:CGFloat){
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
}
