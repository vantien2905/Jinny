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
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgPromotion: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = PRColor.backgroundColor
        imgPromotion.layer.cornerRadius = 2.5
        imgPromotion.layer.masksToBounds = true
        imgPromotion.contentMode = .scaleAspectFill
        vContent.backgroundColor = PRColor.backgroundColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setData(urlImage: String?) {
        if let _url = urlImage {
            let url = URL(string: _url)
            imgPromotion.sd_setImage(with: url, placeholderImage: nil)
        }
    }

}
