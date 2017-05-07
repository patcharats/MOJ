//
//  AlertView.swift
//  MOJ
//
//  Created by CBK-Admin on 4/20/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    let ALERT_OK = "ตกลง"
    let ALERT_CANCEL = "ยกเลิก"
    
    let ALERT_NO_INTERNET = "กรุณาตรวจสอบการเชื่อมต่ออินเตอร์เน็ต"
    let ALERT_NULL_JSON = "ขออภัย ระบบไม่สามารถดำเนินการได้ในขณะนี้ กรุณาลองใหม่อีกครั้ง"
    let ALERT_SESSION_EXPIRE = "เซสชันของคุณหมดอายุ กรุณาเข้าสู่ระบบอีกครั้ง"
    
    let ALERT_WRONG_EMAIL_FORMAT = "กรุณาระบุอีเมลให้ถูกต้อง"
    let ALERT_WRONG_IDCARD_FORMAT = "กรุณาระบุเลขบัตรประชาชนให้ถูกต้อง"
    let ALERT_SOMETHING_WRONG = "พบข้อผิดพลาด กรุณาลองใหม่อีกครั้ง"
    
    // Login
    let ALERT_NULL_INPUT = "กรุณาระบุข้อมูลให้ครบ"
    let ALERT_WRONG_USER_FORMAT = "กรุณาระบุ Username ให้ถูกต้อง"
    let ALERT_USER_DOES_NOT_EXIST = "ไม่มีชื่อบัญชีผู้ใช้นี้ในระบบ"
    let ALERT_WRONG_USER_OR_PASSWORD = "ชื่อบัญชีผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"
    
    // Register
    let ALERT_PASSWORD_6_12_CHAR = "กรุณาระบุรหัสผ่าน 6-12 ตัวอักษร"
    let ALERT_WRONG_RE_PASSWORD = "รหัสผ่านไม่ตรงกัน"
    let ALERT_USER_EXIST = "Username ที่ท่านใช้ได้ทำการลงทะเบียนแล้ว (กด ลืมรหัสผ่าน เพื่อตั้งค่ารหัสผ่าน)"
    let ALERT_REGISTER_SUCCESS = "ลงทะเบียนสำเร็จ กรุณายืนยันตัวตนทางอีเมล แล้วเข้าสู่ระบบใหม่อีกครั้ง"
    
    // Forget Password 
    let ALERT_FORGOT_PASSWORD = "กรุณายืนยันตัวตนและตั้งรหัสผ่านใหม่ได้ทางอีเมล"
    
    // Change Password
    let ALERT_WRONG_OLD_PASSWORD = "กรุณาระบุรหัสผ่านเก่าให้ถูกต้อง"
    let ALERT_WRONG_NEW_PASSWORD = "กรุณาระบุรหัสผ่านใหม่ 6-12 ตัวอักษร"
    let ALERT_CHANGE_PASSWORD_SUCCESS = "เปลี่ยนรหัสผ่านเรียบร้อย"
    
    // Complain
    let INPUT_LIMIT_5_IMAGES = "ใส่ภาพได้สูงสุด 5 ภาพ"
    let ALERT_WRONG_FRONT_ID_NUMBER = "กรุณาระบุหมายเลขบัตรประชาชนให้ถูกต้อง"
    let ALERT_WRONG_BACK_ID_NUMBER = "กรุณาระบุหมายเลขหลังบัตรประชาชนให้ถูกต้อง"
    
    //Psychologist
    let ALERT_CREATE_NEW_SUCCESS = "ส่งคำขอขึ้นทะเบียนเรียบร้อย"
    let ALERT_RENEW_SUCCESS = "ส่งคำขอต่ออายุบัตรเรียบร้อย"
    let ALERT_NULL_REASON = "กรุณาระบุเหตุผลที่ไม่อนุมัติ"
    let ALERT_LOGIN = "กรุณาเข้าสู่ระบบ"
    
    let ALERT_LOGOUT = "คุณต้องการออกจากระบบ?"
    
    //news
    let ALERT_NEWS_NO_INTERNET = "ไม่สามารถคัดกรองข่าวสารได้ กรุณาเชื่อมต่ออินเตอร์เน็ตก่อนค่ะ"
    
    let LOGIN_VIEW_CONTROLLER = "NavigationLogin"
    
    func alert(title:String,message:String,buttonTitle:String,controller: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertWithAction(title:String,message:String,buttonTitle:String,controller: UIViewController,completionHandler:@escaping (Bool) -> ()){

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:buttonTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            completionHandler(true)
        }

        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertWith2Action(title:String,message:String,buttonTitle:String,controller: UIViewController,completionHandler:@escaping (Bool) -> ()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let cancelAction = UIAlertAction(title:ALERT_CANCEL, style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            completionHandler(false)
        }
        
        let okAction = UIAlertAction(title:buttonTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            completionHandler(true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    func setMainViewController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let swRevealViewController = mainStoryBoard.instantiateViewController(withIdentifier: LOGIN_VIEW_CONTROLLER)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = swRevealViewController
        
    }
    
}
