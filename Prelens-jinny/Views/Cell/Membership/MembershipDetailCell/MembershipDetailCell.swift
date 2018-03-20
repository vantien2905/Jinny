//
//  MembershipDetailCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MembershipDetailCell: UITableViewCell {

    @IBOutlet weak var imgPromotion: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = PRColor.backgroundColor
        imgPromotion.layer.cornerRadius = 2.5
        imgPromotion.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
