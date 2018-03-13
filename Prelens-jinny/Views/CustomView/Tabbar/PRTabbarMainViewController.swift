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
    
    //MARK: Declare 3 viewcontroller in Tabbar
    var vcProfile: UIViewController!
    var vcVocher: UIViewController!
    var vcNews: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  delegate = self as! UITabBarControllerDelegate
    
        setUpTabbar()
        
    }
    
    func setUpTabbar() {
        //we setup the delegate, the photo for the tapped or untapped of the tabbar item
        //...
        vcVocher = UIViewController()
        vcVocher.tabBarItem = setBarItem(selectedImage: nil, normalImage: nil)
        
        vcProfile = UIViewController()
        vcProfile.tabBarItem = setBarItem(selectedImage: nil, normalImage: nil)
        
        vcNews = UIViewController()
        vcNews.tabBarItem = setBarItem(selectedImage: nil, normalImage: nil)
        //...
        let tabbarListVC: [UIViewController] = [vcProfile, vcVocher, vcNews]
        
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
        
        addViewControllerToTabbar(listViewController: tabbarListVC)
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



































