//
//  File.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

protocol TabbarMainViewControllerDelegate: class {
    func btnDrawerTabbarTapped()
    func tabbarSelected(index: Int)
}

class PRTabbarMainViewController: UITabBarController {
    
    //  weak var delagateBtnDrawer: TabbarMainViewControllerDelegate?
    
    var membershipVC: PRMemberShipVC?
    let promotionVC = UIViewController()
    let moreVC = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  delegate = self as! UITabBarControllerDelegate
        setUpTabbar()
    }
    
    func setUpTabbar() {
        membershipVC = PRMemberShipVC()
        let nvMembership = UINavigationController(rootViewController: membershipVC!)
      
        nvMembership.tabBarItem = UITabBarItem(title: "Memberships", image: PRPhoto.tabbarMembershipOff, selectedImage: nil)
      
        let nvPromotions = UINavigationController(rootViewController: promotionVC)
        nvPromotions.tabBarItem = UITabBarItem(title: "Promotions", image: PRPhoto.tabbarPromotionsOff, selectedImage: nil)
        
        let nvMore = UINavigationController(rootViewController: moreVC)
        nvMore.tabBarItem = UITabBarItem(title: "More...", image: PRPhoto.tabbarMore, selectedImage: nil)
        
        let tabbarListVC: [UIViewController] = [nvMembership, nvPromotions, nvMore]
        viewControllers = tabbarListVC
        
        
        //IphoneX configuration
        //        for controller in tabbarListVC {
        //            if DeviceTypeHelper.getDeviceType() != NCSDeviceType.small {
        //                if Device() == .iPhoneX || Device() == .simulator(.iPhoneX) {
        //                    controller.tabBarItem.imageInsets = tabIconInsetsX
        //                } else {
        //                    controller.tabBarItem.imageInsets = tabIconInsets
        //                }
        //            }
        //        }
    }
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //     delagateBtnDrawer?.tabbarSelected(index: tabBarController.selectedIndex)
        //  tabLeft.setIndexSelected(index: tabBarController.selectedIndex)
        
        //MARK: Delegate Action here when item was tapped
    }
}
