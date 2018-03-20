//
//  PromotionDetailCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 19/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionDetailCell: UICollectionViewCell {

    @IBOutlet weak var imvPromotionDetail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setUpComponents() {
        imvPromotionDetail.contentMode = .scaleAspectFit
    }
    
}
