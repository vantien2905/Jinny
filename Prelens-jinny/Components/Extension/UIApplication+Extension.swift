//
//  UIApplication+Extension.swift
//  Prelens-jinny
//
//  Created by Lamp on 20/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

extension UIApplication {
    static var rootVC: UITabBarController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
