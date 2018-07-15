//
//  UICollectionViewDelegateFlowLayout+Extension.swift
//  Prelens-jinny
//
//  Created by Tien Dinh on 4/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

extension UICollectionViewDelegateFlowLayout {

    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    @available(iOS 6.0, *)
    optional public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}
