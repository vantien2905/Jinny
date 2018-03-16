//
//  MembershipCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class MembershipCell: UICollectionViewCell {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgMemberShip: UIImageView!
    @IBOutlet weak var imgStar: UIImageView!
    
    var membership = Member() {
        didSet {
            self.setData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
        setData()
    }
    
    func setUpView() {
        vContent.layer.borderWidth = 0.5
        vContent.layer.borderColor = PRColor.lineColor.cgColor
    }
    
    func setData() {
        if let _merchant = membership.merchant,
        let _logo = _merchant.logo,
        let _url = _logo.url,
            let _urlLogo = _url.thumb {
            let url = URL(string: _urlLogo)
            imgMemberShip.sd_setImage(with: url, placeholderImage: nil)
        }
    }

}
