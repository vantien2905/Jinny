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
        // Initialization code
    }
    
    func setupView() {
        vLine.backgroundColor = PRColor.lineColor
        vContent.backgroundColor = PRColor.backgroundColor
    }
    
    func setData() {
        if  let _expiresAt = promotion.expiresString, let _merchantName = promotion.merchant?.name, let _url = promotion.image?.url?.medium {
            let url = URL(string: _url)
            lbExpiresAt.text    = "Expiry date: \(_expiresAt)"
            lbMerchantName.text = _merchantName
            imgPromotion.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }

}
