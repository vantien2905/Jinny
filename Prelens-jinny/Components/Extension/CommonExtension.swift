//
//  CommonExtension.swift
//  Prelens-jinny
//
//  Created by Lamp on 20/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import SDWebImage

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width)+1
    }
    
    func scrollToBottom(_ animated: Bool) {
        let bottomY = self.contentSize.height - self.bounds.size.height
        
        // Only meaningful when we have positive bottomY
        if bottomY > 0 {
            let bottomOffset = CGPoint(x: 0, y: bottomY)
            self.setContentOffset(bottomOffset, animated: animated)
        }
    }
}

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type, registerType: CellRegisterType) {
        if registerType == .tNib {
            self.register(UINib(nibName: cellType.identifier, bundle: nil), forCellWithReuseIdentifier: cellType.identifier)
        } else {
            self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
        }
    }
}

extension UIImageView {
    func sd_setImage(with path: String,
                     placeholder: UIImage? = #imageLiteral(resourceName: "image_loading"),
                     failedImage: UIImage? = #imageLiteral(resourceName: "image_not_found")) {

        sd_setImage(with: URL(string: path), placeholderImage: placeholder) { (image, error, _, _) in
            guard let _ = image, error == nil else {
                self.image = failedImage
                return
            }
        }
    }
}

