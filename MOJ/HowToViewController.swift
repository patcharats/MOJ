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
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var slideshow: ImageSlideshow!
    var localSource:[ImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        
        for i in 1 ..< 14 {
            
            let imageString = "hw"+String(i)
            let ImageSources = ImageSource.init(imageString: imageString)
            localSource.append(ImageSources!)
        }
        
        setupSlideShow()
        
    }
    
    func setupSlideShow(){
        slideshow.slideshowInterval = 5.0
        slideshow.backgroundColor = UIColor.clear
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            //print("current page:", page)
        }
        slideshow.setImageInputs(localSource)
    }
    
    func setupMenuButton() {
        if revealViewController() != nil {
            let percent = self.view.frame.size.width - ((self.view.frame.size.width * 30)/100)
            revealViewController().rearViewRevealWidth = percent
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

