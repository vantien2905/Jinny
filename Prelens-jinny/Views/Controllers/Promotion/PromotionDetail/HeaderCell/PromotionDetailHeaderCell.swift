//
//  PromotionDetailHeaderCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 19/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionDetailHeaderCell: UICollectionViewCell {

    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var lbExpireDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpView(with data: Promotion) {
        self.backgroundColor = .white
        tvName.isUserInteractionEnabled = false
        tvName.text = "Name of Merchant here....Name of Merchant here...."
        tvName.backgroundColor = .clear
        
        tvName.text = data.merchant?.name
        lbExpireDate.text = data.expiresAt
        
    }
}
