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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  delegate = self as! UITabBarControllerDelegate
        setUpTabbar()
    }
    
    func setUpTabbar() {
        membershipVC = PRMemberShipVC()
        let nvMembership = UINavigationController(rootViewController: membershipVC!)
        
        let tabbarListVC: [UIViewController] = [nvMembership]
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
    
    //Config item when it was tapped on
    func setBarItem(selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: normalImage, selectedImage: selectedImage)
        return item
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //     delagateBtnDrawer?.tabbarSelected(index: tabBarController.selectedIndex)
        //  tabLeft.setIndexSelected(index: tabBarController.selectedIndex)
        
        //MARK: Delegate Action here when item was tapped
    }
    
    //Adding the tabbar Viewcontroller into list
    func addViewControllerToTabbar(listViewController: [UIViewController]) {
        var listNavigationController = [UINavigationController]()
        for vc in listViewController {
            let nc = UINavigationController(rootViewController: vc)
            listNavigationController.append(nc)
        }
        //---
        self.viewControllers = listNavigationController
    }
}
