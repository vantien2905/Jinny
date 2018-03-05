//
//  File.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class PRTabbarMainViewController: UITabBarController {
    
    //MARK: Declare 3 viewcontroller in Tabbar
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    
        setUpTabbar()
        
    }
    
    func setUpTabbar() {
        
    }
    
    //Config item when it was tapped on
    func setBarItem(selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: normalImage, selectedImage: selectedImage)
        return item
    }
}
