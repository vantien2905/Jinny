//
//  Navigator.swift
//  Prelens-jinny
//
//  Created by vinova on 4/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    static let shared = Navigator()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func handle(route: Route, id: String?) {
        switch route {
        case .tab(let tab):
            if let navigationController = appDelegate?.window?.rootViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: true)
            }
            
            appDelegate?.tabbarController?.btnTapped(tag: tab)
            if let _id = id {
                let vc = PromotionDetailViewController.configureViewController(idVoucher: _id)
//              vc.navigationController?.navigationBar.isHidden = false
                appDelegate?.tabbarController?.push(controller: vc, animated: true)
            }
            
        case .signIn: break
        case .signUp: break
        }
    }
}
