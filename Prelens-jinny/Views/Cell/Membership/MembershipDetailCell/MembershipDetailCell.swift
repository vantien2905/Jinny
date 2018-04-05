//
//  MembershipDetailCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class MembershipDetailCell: UITableViewCell {
    
    var promotion = Promotion() {
        didSet {
            self.setData()
        }
    }
    
    @IBOutlet weak var lbExpiresAt: UILabel!
    @IBOutlet weak var lbMerchantName: UILabel!
    @IBOutlet weak var vLine: UIView!
    @IBOutlet weak var imgPromotion: UIImageView!
    @IBOutlet weak var vContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setupView() {
        vLine.backgroundColor = PRColor.lineColor
        vContent.backgroundColor = PRColor.backgroundColor
    }
    
    func setData() {
        if  let _expiresAt = promotion.expiresString, let _merchantName = promotion.merchant?.name {
            if let _url = promotion.image?.url?.original {
                let url = URL(string: _url)
                //                 imgPromotion.sd_setImage(with: url, placeholderImage: nil)
                
                imgPromotion.sd_setImage(with: url, placeholderImage: nil) { (image, error, _, _) in
                    guard let _image = image, error == nil else {
                        return
                    }
                    let point = CGPoint(x: 0, y: 0)
                    if _image.size.height > _image.size.width {
                        let size = CGSize(width: _image.size.width, height: _image.size.width * (163/313))
                        self.imgPromotion.image = _image.crop(rect: CGRect(origin: point, size: size))
                        
                    } else {
                        self.imgPromotion.image = _image
                    }
                }
                self.imgPromotion.contentMode = .scaleToFill
            }
            lbExpiresAt.text    = "Expiry date: \(_expiresAt)"
            lbMerchantName.text = _merchantName
        }
    }
}
