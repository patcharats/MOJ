//
//  StringHelper.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import CryptoSwift

class StringHelper:NSObject{
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func getCurrentDateTimeString()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let datetime = formatter.string(from: date)
        
        return datetime
    }
    
    func getDatefromString(dateString:String)->String{
        
        if dateString.isEmpty {
            return dateString
        }
        else if dateString.contains("/"){
            let dateStringArr = dateString.components(separatedBy: "/")
            //7/27/2015  1:13:48 PM
            let day   = dateStringArr[1]
            let month = (dateStringArr[0] as NSString).integerValue
            let yearandtime = dateStringArr[2]
            
            let dayStringArr  = yearandtime.components(separatedBy: " ")
            let year = dayStringArr[0]
            
            return day+" "+getMonthTH(month: month)+" "+year
        }
        else {
            let dateStringArr = dateString.components(separatedBy: "-")
            //2017-04-12 14:51:05
            let dayandtime  = dateStringArr[2]
            
            let dayStringArr  = dayandtime.components(separatedBy: " ")
            let day = dayStringArr[0]
            
            let month = (dateStringArr[1] as NSString).integerValue
            let year = dateStringArr[0]
            
            return day+" "+getMonthTH(month: month)+" "+year
        }
        
        
    }
    
    
    func getMonthTH(month:Int)->String{
        var monthString = ""
        
        switch month {
        case 1:
            monthString = "ม.ค."
        case 2:
            monthString = "ก.พ."
        case 3:
            monthString = "มี.ค."
        case 4:
            monthString = "เม.ย."
        case 5:
            monthString = "พ.ค."
        case 6:
            monthString = "มี.ย."
        case 7:
            monthString = "ก.ค."
        case 8:
            monthString = "ส.ค."
        case 9:
            monthString = "ก.ย."
        case 10:
            monthString = "ต.ค."
        case 11:
            monthString = "พ.ย."
        case 12:
            monthString = "ธ.ค."
        default:
            break
        }
        
        return monthString
    }
    
    
    func validatePersionId(stringPersionId:String) -> Bool{
        if stringPersionId.characters.count < 13 {
            return false
        }
        var sum = 0
        for index in 0..<stringPersionId.characters.count-1 {
            let char = stringPersionId[index]
            do {
                let intData = Int(char)
                sum += intData! * (13-index)
            } catch let error {
                print("error \(error)")
                break;
                return false
            }
            
        }
        
        do {
            let char    = stringPersionId[stringPersionId.characters.count-1]
            let intData = Int(char)
            if((11-(sum%11))%10 == intData) {
                return true
            } else {
                return false
            }
        } catch let error {
            print("error \(error)")
            return false
        }
        
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func getAesString(plainText:String) -> String? {
        do {
            let key         = "bcb04b7e103a0cd8b54763051cef08bc"
            let iv          = "55abe029fdebae5e"
            let encrypted   = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7())
            let ciphertext  = try encrypted.encrypt(Array(plainText.utf8))
            
            return ciphertext.toBase64()
        } catch {
            return ""
        }
    }
    
    func getStringFromAes(aesString:String) -> String? {
        do {
            let key         = "bcb04b7e103a0cd8b54763051cef08bc"
            let iv          = "55abe029fdebae5e"
            let cipher      = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7())
            let plainString = try aesString.decryptBase64ToString(cipher: cipher)
            return plainString
        } catch {
            return ""
        }
    }
}

extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in :NSCharacterSet.whitespaces)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    subscript(pos: Int) -> String {
        precondition(pos >= 0, "character position can't be negative")
        guard pos < characters.count else { return "" }
        let idx = index(startIndex, offsetBy: pos)
        return self[idx...idx]
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
