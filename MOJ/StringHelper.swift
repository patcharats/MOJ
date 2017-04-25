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
