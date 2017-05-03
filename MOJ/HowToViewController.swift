//
//  HowToViewController.swift
//  MOJ
//
//  Created by patcharat on 3/21/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class HowToViewController: UIViewController {
    let SW_REVEAL_VIEW_CONTROLLER = "SWRevealViewController"
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    let IMAGE_CHECK_BOX_TRUE = "checkbox_on"
    let IMAGE_CHECK_BOX_FALSE = "checkbox_off"
    var imageName = ""
    var isShowHowto = false
    var accountData = AccountData()
    var localSource:[ImageSource] = []
    let design = Design()
    let network = Network()
    let configData = ConfigData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1 ..< 14 {
            
            let imageString = "hw"+String(i)
            let ImageSources = ImageSource.init(imageString: imageString)
            localSource.append(ImageSources!)
        }
        
        checkboxButton.setImage(UIImage (named: IMAGE_CHECK_BOX_FALSE), for: UIControlState.normal)
        self.startButton.backgroundColor = UIColor.gray
        startButton.isEnabled = false
        setupSlideShow()
        design.roundView(view: startButton, radius: 5)
        
        
        
        network.get(name: network.API_CONFIG, param:"", viewController: self, completionHandler: {
            (json:Any,Code:String,Message:String) in
            
            self.configData.getConfigData(json: json)
            
            self.network.get(name: self.network.API_CONFIG_PROVINCE, param:"", viewController: self, completionHandler: {
                (json:Any,Code:String,Message:String) in
                
                self.configData.getConfigProvince(json: json)
            })
        })
        
    }
    
    @IBAction func checkBoxButton(_ sender: Any) {
        SetCheckBox()
    }
    @IBAction func startButton(_ sender: Any) {
        setMainViewController()
    }
    
    func setMainViewController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let swRevealViewController = mainStoryBoard.instantiateViewController(withIdentifier: SW_REVEAL_VIEW_CONTROLLER)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = swRevealViewController
        
    }
    
    func SetCheckBox(){
        if isShowHowto {
            isShowHowto = false
            imageName = IMAGE_CHECK_BOX_FALSE
        }
        else{
            isShowHowto = true
            imageName = IMAGE_CHECK_BOX_TRUE
        }
        
        accountData.setShowHowto(isShowHowto: isShowHowto)
        checkboxButton.setImage(UIImage (named: imageName), for: UIControlState.normal)
        
    }
    
    func setupSlideShow(){
        slideshow.circular = false
        slideshow.slideshowInterval = 5.0
        slideshow.backgroundColor = UIColor.clear
        slideshow.pageControlPosition = PageControlPosition.custom(padding: 20)
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            //print("current page:", page)
            
            if page == 12 {
                self.slideshow.slideshowInterval = 0.0
                self.startButton.isEnabled = true
                self.startButton.backgroundColor = self.design.hexStringToColor(hex: self.design.HEX_COLOR_ORANGE)
            }
            else{
                self.slideshow.slideshowInterval = 5.0
                self.startButton.isEnabled = false
                self.startButton.backgroundColor = UIColor.gray
            }
            
        }
        slideshow.setImageInputs(localSource)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

