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
        setUpView()
        setData()
    }

    func setUpView() {
        imgMemberShip.contentMode = .scaleAspectFit
//        imgMemberShip.clipsToBounds = false
        vContent.layer.borderWidth = 0.5
        vContent.layer.borderColor = PRColor.lineColor.cgColor
//        imgMemberShip.layer.borderWidth = 0.5
//        imgMemberShip.layer.borderColor = PRColor.lineColor.cgColor
        vContent.layer.cornerRadius = 2.5
        vContent.layer.masksToBounds = true
        
    }

    func setData() {
        if let _merchant = membership.merchant,
        let _logo = _merchant.logo,
        let _url = _logo.url,
            let _urlLogo = _url.original {
            let url = URL(string: _urlLogo)
            imgMemberShip.sd_setImage(with: url, placeholderImage: nil)
        }
    }

}
