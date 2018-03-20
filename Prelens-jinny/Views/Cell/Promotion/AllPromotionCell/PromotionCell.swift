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
    @IBOutlet weak var imgPromotion: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setData()
        // Initialization code
    }
    
    func setupView() {
        vLine.backgroundColor = PRColor.lineColor
    }
    
    func setData() {
        if  let _expiresAt = promotion.expiresAt, let _merchantName = promotion.merchant?.name,  let _url = promotion.image?.url?.medium {
            let url = URL(string: _url)
            lbExpiresAt.text    = _expiresAt
            lbMerchantName.text = _merchantName
            imgPromotion.sd_setImage(with: url, placeholderImage: nil)
        }
    }
}
