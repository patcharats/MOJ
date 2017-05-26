//
//  PsychoSeviceCreateNew.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class PsychoServiceCreateNew: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var confirmView: UIView!
    var socialWorkData = SocialWorkData()
    var param = PsychoParameter()
    let notificationName = Notification.Name("clearTextfieldCreate")
    let titles = ["ข้อมูลส่วนตัว","อาชีพและการศึกษา","ข้อมูลอื่นๆ","หลักฐาน"]
    
    
    @IBOutlet weak var clearBarButton: UIBarButtonItem!
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
            tutorialPageViewController?.typeViewController = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let readOnly = socialWorkData.isReadOnly()
        
        if readOnly {
            clearBarButton.title = ""
            clearBarButton.isEnabled = false
            confirmView.isHidden = true
        }
        else{
            clearBarButton.title = "ล้าง"
            clearBarButton.isEnabled = true
            confirmView.isHidden = false
        }
        
        pageControl.addTarget(self, action: #selector(PsychoServiceCreateNew.didChangePageControlValue), for: .valueChanged)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearTextfield(_ sender: Any) {
        print("clear")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func registerButton(_ sender: Any) {
        print("create new")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    
}




extension PsychoServiceCreateNew: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        titleLabel.text = titles[index]
    }
    
}
