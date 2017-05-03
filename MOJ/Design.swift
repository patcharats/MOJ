//
//  Design.swift
//  MOJ
//
//  Created by CBK-Admin on 4/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
class Design: NSObject {
    
    let HEX_COLOR_ORANGE = "F15F4B"
    let HEX_COLOR_BLUE = "29ABE2"
    let HEX_COLOR_YELLOW = "FBAE17"
    let HEX_COLOR_GREEN = "67AC47"
    let HEX_COLOR_RED = "B53447"
    
    func getProcessStatus(status:String,label:UILabel){
        switch status {
        case "create":
            label.text = "รับเรื่อง"
            label.backgroundColor = hexStringToColor(hex: HEX_COLOR_BLUE)
        case "process":
            label.text = "กำลังดำเนินการ"
            label.backgroundColor = hexStringToColor(hex: HEX_COLOR_YELLOW)
        case "close":
            label.text = "ปิดเรื่อง"
            label.backgroundColor = hexStringToColor(hex: HEX_COLOR_GREEN)
        case "reject":
            label.text = "ไม่รับเรื่อง"
            label.backgroundColor = hexStringToColor(hex: HEX_COLOR_RED)
        default:
            label.text = status
            label.backgroundColor = UIColor.black
        }
    }
    
    
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
    
    func hexStringToColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
