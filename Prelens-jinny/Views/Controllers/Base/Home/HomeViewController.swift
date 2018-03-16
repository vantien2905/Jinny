//
//  PRNewBaseVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 15/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var vContainer: UIView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vNavigation: UIView!
    @IBOutlet weak var lcsNavigationHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    @IBOutlet weak var vTabbar: PRTabbarCustom!
    
    @IBOutlet weak var lcsSideMenu: NSLayoutConstraint!
    @IBOutlet weak var vSideMenu: UIView!
    @IBOutlet weak var vCloseTap: UIView!
    
    let sideMenuVC = PRSideMenuVC.initControllerFromNib()
    var sideMenuTrigger: Bool = true
    
    let membershipVC = PRMemberShipVC.initControllerFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        vTabbar.buttonTappedDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addSubView()
    }
    
    func setUpView() {
        
        vNavigation.backgroundColor = PRColor.mainAppColor
        lcsNavigationHeight.constant = (60/667)*(UIScreen.main.bounds.height)
        
        vTabbar.vMemberships.setTitle(title: "Memberships")
        vTabbar.vPromotions.setTitle(title: "Promotions")
        vTabbar.vMore.setTitle(title: "More")
        
        btnLeft.isHidden = true
        vCloseTap.isHidden = true
        
        //Setup the tapped Button in first time
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
        membershipVC.view.frame = vContainer.bounds
        self.vContainer.addSubview(membershipVC.view)
        
        //SideMenu
        self.addChildViewController(sideMenuVC)
        sideMenuVC.view.frame = vSideMenu.bounds
        self.vSideMenu.addSubview(sideMenuVC.view)
        sideMenuVC.view.fillSuperview()
    }
    
    @IBAction func handleTap(_ sender: Any) {
        lcsSideMenu.constant = 248
        UIView.animate(withDuration: 0.2, animations: self.view.layoutIfNeeded, completion: nil)
        sideMenuTrigger = !sideMenuTrigger
        vCloseTap.isHidden = true
    }
}

//MARK: Button Action
extension HomeViewController: PRTabbarCustomDelegate {
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


