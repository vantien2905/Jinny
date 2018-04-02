//
//  PromotionCell.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    var promotion = Promotion() {
        didSet {
            self.setData()
        }
    }
    
    @IBOutlet weak var lbExpiresAt: UILabel!
    @IBOutlet weak var lbMerchantName: UILabel!
    @IBOutlet weak var vLine: UIView!
    @IBOutlet weak var imgReadPromotion: UIImageView!
    @IBOutlet weak var imgPromotion: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setData()
        // Initialization code
    }
    
    func setupView() {
        imgReadPromotion.layer.cornerRadius = 2.5
        vLine.backgroundColor = PRColor.lineColor
    }
    
    func setData() {
        if  let _expiresAt = promotion.expiresString, let _merchantName = promotion.merchant?.name,  let _url = promotion.image?.url?.original {
            if promotion.isReaded {
                imgReadPromotion.isHidden = true
            } else {
                imgReadPromotion.isHidden = false
            }
            let url = URL(string: _url)
            lbExpiresAt.text    = _expiresAt
            lbMerchantName.text = _merchantName
            
            imgPromotion.contentMode = .scaleAspectFill
            imgPromotion.sd_setImage(with: url, placeholderImage: nil)
        }
    }
}
