//
//  PRNewBaseVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 15/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRNewBaseVC: UIViewController {

    @IBOutlet weak var vDetail: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vNavigation: UIView!
    @IBOutlet weak var lcsNavigationHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    @IBOutlet weak var vTabbar: PRTabbarCustom!
    
    @IBOutlet weak var lcsSideMenu: NSLayoutConstraint!
    @IBOutlet weak var vsSideMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        vTabbar.buttonTappedDelegate = self
        
    }
    
    func setUpView() {
        lcsNavigationHeight.constant = (60/667)*(UIScreen.main.bounds.height)
        vTabbar.vMore.setTitle(title: "More")
        lbTitle.text = "JINNY"
        
        self.navigationController?.navigationBar.isHidden = true
        vNavigation.backgroundColor = PRColor.mainAppColor
        btnLeft.isHidden = true
    }
    
    func setTitle(title: String) {
        lbTitle.text = title
    }
    
    func setBackButton(image: UIImage) {
        btnLeft.imageView?.image = image
    }
    
    func setRightButton(image: UIImage) {
        btnRight.imageView?.image = image
    }
    
}
//MARK: Button Action
extension PRNewBaseVC: PRTabbarCustomDelegate {
    func btnTapped(tag: Int) {
        switch tag {
        case 2:
            print("11!")
            
            lcsSideMenu.constant = 0
            UIView.animate(withDuration: 1, animations: self.view.layoutIfNeeded, completion: nil)
            
        default:
            print("wqe")
        }
    }
    
    @IBAction func btnLeftAction() {
        self.pop()
    }
    
    @IBAction func btnRightAction() {
        
    }
    
    
}


