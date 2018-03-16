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
    @IBOutlet weak var vCloseTap: UIView!
    
    let sideMenuVC = PRSideMenuVC.initControllerFromNib()
    var sideMenuTrigger: Bool = true
    
    let membershipVC = PRMemberShipVC.initControllerFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vTabbar.buttonTappedDelegate = self
        
        setUpView()
        addSubView()
    }
    
    func setUpView() {
        vNavigation.backgroundColor = PRColor.mainAppColor
        lcsNavigationHeight.constant = (60/667)*(UIScreen.main.bounds.height)
        lbTitle.text = "JINNY"
        
        vTabbar.vMemberships.setTitle(title: "Memberships")
        vTabbar.vPromotions.setTitle(title: "Promotions")
        vTabbar.vMore.setTitle(title: "More")
        
        vNavigation.backgroundColor = PRColor.mainAppColor
        btnLeft.isHidden = true
        
        vTabbar.setIndexSelected(index: 0)
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
    
    func addSubView() {
        //Membership
        self.addChildViewController(membershipVC)
        membershipVC.view.frame = vDetail.bounds
        self.vDetail.addSubview(membershipVC.view)
        
        //SideMenu
        sideMenuVC.view.frame = vsSideMenu.bounds
        self.vsSideMenu.addSubview(sideMenuVC.view)
    }
    
    @IBAction func handleTap(_ sender: Any) {
        lcsSideMenu.constant = 248
        UIView.animate(withDuration: 0.2, animations: self.view.layoutIfNeeded, completion: nil)
        sideMenuTrigger = !sideMenuTrigger
        vCloseTap.isHidden = true
    }
    
}

//MARK: Button Action
extension PRNewBaseVC: PRTabbarCustomDelegate {
    func btnTapped(tag: Int) {
        switch tag {
        case 0:
            print("0")
            vTabbar.setIndexSelected(index: 0)
            
        case 1:
            print("1")
            vTabbar.setIndexSelected(index: 1)
            
        case 2:
            print("more")
            if sideMenuTrigger {
                lcsSideMenu.constant = 0
                UIView.animate(withDuration: 0.3, animations: self.view.layoutIfNeeded, completion: { (_) in
                    self.sideMenuTrigger = !self.sideMenuTrigger
                    self.vCloseTap.isHidden = false
                    self.vCloseTap.backgroundColor = .gray
                    self.vCloseTap.alpha = 0.3
                })
            }
   
        default:
            break
        }
    }
    
    @IBAction func btnLeftAction() {
        self.pop()
    }
    
    @IBAction func btnRightAction() {
        
    }
}

extension PRNewBaseVC: NavigationDelegate {
    func pushTo(data: String) {
        print(data)
    }
    
    
}

