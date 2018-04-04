//
//  Utils.swift
//  Prelens-jinny
//
//  Created by Lamp on 3/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class Utils {
    class func getMinimumWidthHeight() -> CGFloat {
        return CGFloat.minimum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    class func getMaximumWidthHeight() -> CGFloat {
        return CGFloat.maximum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    class func isIphoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            return true
        }
        
        return false
    }
}
