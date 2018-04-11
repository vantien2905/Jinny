
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
    
    @IBOutlet weak var vNavigation: UIView!
    @IBOutlet weak var lcsNavigationHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    @IBOutlet weak var vTabbar: PRTabbarCustom!
    @IBOutlet weak var heightTabbar: NSLayoutConstraint!
    @IBOutlet weak var bottomTitleNavi: NSLayoutConstraint!
    
    @IBOutlet weak var lcsHeightSideMenu: NSLayoutConstraint!
    @IBOutlet weak var lcsSideMenu: NSLayoutConstraint!
    @IBOutlet weak var vSideMenu: UIView!
    @IBOutlet weak var vCloseTap: UIView!
    let sideMenuVC = PRSideMenuVC.initControllerFromNib()
    var sideMenuTrigger: Bool = true
    
    let membershipVC = MemberShipViewController.initControllerFromNib() as! MemberShipViewController
    let promotionVC  = PromotionViewController.initControllerFromNib() as! PromotionViewController
    
    var numbers = 0 {
        didSet {
           vTabbar.vPromotions.setNotificationCounter(count: numbers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        vTabbar.buttonTappedDelegate = self
        
        //Hide the sidemenu after back from VC in side menu
        if !sideMenuTrigger {
            lcsSideMenu.constant = UIScreen.main.bounds.width * 2/3
            sideMenuTrigger = !sideMenuTrigger
            vCloseTap.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.updateBadgeTabbar), name: NSNotification.Name(rawValue: ConstantNotification.updateBadgeVoucherTabbar), object: nil)
        addSubView()
        setUpView()
        
    }
    
    @objc func updateBadgeTabbar() {
        let defaults = UserDefaults.standard
        numbers = defaults.integer(forKey: KeychainItem.badgeNumber.rawValue)
    }
    
    func setUpView() {
        let defaults = UserDefaults.standard
        vNavigation.backgroundColor = PRColor.mainAppColor
        lcsNavigationHeight.constant = 64
        if Device() == .iPhoneX || Device() == .simulator(.iPhoneX) {
            self.heightTabbar.constant = 83
            self.bottomTitleNavi.constant = 5
        } else {
            self.heightTabbar.constant = 50
            self.bottomTitleNavi.constant = 10
        }
        vSideMenu.backgroundColor = .green
        vTabbar.vMemberships.setTitle(title: PRButtonTabbarTitle.btnMemberships)
        vTabbar.vPromotions.setTitle(title: PRButtonTabbarTitle.btnVouchers)
        vTabbar.vMore.setTitle(title: PRButtonTabbarTitle.btnMore)
        
        btnLeft.isHidden = true
        vCloseTap.isHidden = true
        
        //Setup the tapped Button in first time
        vTabbar.setIndexSelected(index: 0)
        
        //Setup the size of SideMenu
        lcsSideMenu.constant = UIScreen.main.bounds.width * 2/3
        lcsHeightSideMenu.constant = UIScreen.main.bounds.width * 2/3
        
        vTabbar.vPromotions.setNotificationCounter(count: numbers)
        vTabbar.vMemberships.setNotificationCounter(count: 0)
        vTabbar.vMore.setNotificationCounter(count: 0)
        
        membershipVC.delegateScroll = self
        promotionVC.vcAllPromotion.delegateScroll = self
        promotionVC.vcAchivedPromotion.delegateScroll = self
        promotionVC.vcStarredPromotion.delegateScroll = self
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

    }
    
    func switchScreen(from VC1: UIViewController, to VC2: UIViewController) {
        self.transition(from: VC1, to: VC2, duration: 0, options: UIViewAnimationOptions.allowAnimatedContent,
                        animations: nil, completion: nil)
    }
    
    @IBAction func handleTap(_ sender: Any) {
        lcsSideMenu.constant = UIScreen.main.bounds.width * 2/3
        UIView.animate(withDuration: 0.2, animations: self.view.layoutIfNeeded, completion: nil)
        sideMenuTrigger = !sideMenuTrigger
        vCloseTap.isHidden = true
    }
}

// MARK: Button Action
extension HomeViewController: PRTabbarCustomDelegate {
    
    func removeViewController(controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    func addMainViewController(controller: UIViewController) {
        removeViewController(controller: controller)
        addChildViewController(controller)
        
        self.vContainer.addSubview(controller.view)
        controller.view.fillSuperview()

        controller.didMove(toParentViewController: self)
    }
    
    func btnTapped(tag: Route.Tabbar) {
        switch tag {
        case .membership:
//            if self.childViewControllers.contains(promotionVC) {
//                switchScreen(from: promotionVC, to: membershipVC)
//            }
            self.lcsNavigationHeight.constant = 64
            addMainViewController(controller: membershipVC)
            vTabbar.setIndexSelected(index: 0)
        case .vouchers:
            
//            if !self.childViewControllers.contains(promotionVC) {
//                //Adding Promotion child view controller
//                self.addChildViewController(promotionVC)
//                promotionVC.view.frame = vContainer.bounds
//                self.vContainer.addSubview(promotionVC.view)
//                promotionVC.view.fillSuperview()
//            }
//            switchScreen(from: membershipVC, to: promotionVC)
            self.lcsNavigationHeight.constant = 64
            addMainViewController(controller: promotionVC)
            vTabbar.setIndexSelected(index: 1)
            
        case .more:
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

extension HomeViewController: ScrollDelegate {
    func isScroll(direction: Bool) {
        self.view.layoutIfNeeded()
        if direction {
            UIView.animate(withDuration: 0.3, animations: {
                self.lcsNavigationHeight.constant = 0
                self.view.layoutIfNeeded()
            })
            
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.lcsNavigationHeight.constant = 64
                self.view.layoutIfNeeded()
            })
        }
        
    }
}
