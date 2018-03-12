//
//  UIImage+Extension.swift
//  Prelens-jinny
//
//  Created by Lamp on 10/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

extension UIImage {
    var uncompressedPNGData: NSData?      { return UIImagePNGRepresentation(self) as NSData?        }
    var highestQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 1.0) as NSData?  }
    var highQualityJPEGNSData: NSData?    { return UIImageJPEGRepresentation(self, 0.7) as NSData?  }
    var mediumQualityJPEGNSData: NSData?  { return UIImageJPEGRepresentation(self, 0.5) as NSData?  }
    var lowQualityJPEGNSData: NSData?     { return UIImageJPEGRepresentation(self, 0.25) as NSData? }
    var lowestQualityJPEGNSData:NSData?   { return UIImageJPEGRepresentation(self, 0.08) as NSData? }
}


extension UIImage {
    static func getAlwaysOriginal(named: String) -> UIImage? {
        return UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
    }
    
    func resize(to _size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: _size.width, height: _size.height), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: _size.width, height: _size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
