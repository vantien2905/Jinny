//
//  UIImage+Extension.swift
//  Prelens-jinny
//
//  Created by Lamp on 10/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImage {
    var uncompressedPNGData: NSData? { return UIImagePNGRepresentation(self) as NSData?        }
    var highestQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 1.0) as NSData?  }
    var highQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 0.7) as NSData?  }
    var mediumQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 0.5) as NSData?  }
    var lowQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 0.25) as NSData? }
    var lowestQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 0.08) as NSData? }
}

extension UIImage {
    static func getAlwaysOriginal(named: String) -> UIImage? {
        return UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
    }

    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func crop( rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
}
