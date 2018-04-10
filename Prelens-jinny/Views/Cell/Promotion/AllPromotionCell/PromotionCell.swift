//
//  PromotionCell.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
//import SDWebImage

class PromotionCell: UICollectionViewCell {
    var promotion = Promotion() {
        didSet {
            self.setData()
        }
    }
    
    var imvTemp: UIImageView?
    
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
        if  let _expiresAt = promotion.expiresString, let _merchantName = promotion.merchant?.name {
            if promotion.isReaded {
                imgReadPromotion.isHidden = true
            } else {
                imgReadPromotion.isHidden = false
            }
            lbExpiresAt.text    = _expiresAt
            lbMerchantName.text = _merchantName
        }
        
        if let _url = promotion.image?.url?.original {
            let url = URL(string: _url)
            imgPromotion.sd_setImage(with: url, placeholderImage: nil) { (image, error, _, _) in
                guard let _image = image, error == nil else {
                    return
                }
                let point = CGPoint(x: 0, y: 0)
                    let height = (0.75*300)*(_image.size.width)/(UIScreen.main.bounds.width - 12)
                    let size = CGSize(width: _image.size.width, height: height)
                    self.imgPromotion.image = _image.crop(rect: CGRect(origin: point, size: size))
                    self.imgPromotion.contentMode = .scaleToFill
            }
        }
    }
}
