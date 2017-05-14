//
//  PsychoServiceRenew.swift
//  MOJ
//
//  Created by patcharat on 4/23/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import Foundation
import UIKit
class PsychoServiceRenew: UIViewController {
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var titleHeight: NSLayoutConstraint!
    @IBOutlet var titleLabelHeight: NSLayoutConstraint!
    let titles = ["ชื่อและข้อมูลทะเบียน","ข้อมูลส่วนตัว","ข้อมูลการทำงาน","ข้อมูลการปฎิบัติหน้าที่เป็นผู้ทำหน้าที่\nนักจิตวิทยาหรือนักสังคมสงเคราะห์"]
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
            tutorialPageViewController?.typeViewController = 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(PsychoServiceCreateNew.didChangePageControlValue), for: .valueChanged)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clearTextfield(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func renewButton(_ sender: Any) {
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



extension PsychoServiceRenew: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        titleLabel.text = titles[index]
        
        if index == 3 {
            titleHeight.constant = 50
            titleLabelHeight.constant = 57
        }
        else{
            titleHeight.constant = 34
            titleLabelHeight.constant = 40
            
        }
    }
    
}
