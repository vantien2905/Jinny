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
    
    @IBOutlet weak var lcsMerchantNameHeight: NSLayoutConstraint!
    @IBOutlet weak var lcsSideConstraintName: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpView(with data: Promotion) {
        self.backgroundColor = .white
        tvName.isUserInteractionEnabled = false
        tvName.backgroundColor = .clear
        
        lcsMerchantNameHeight.constant = getHeight(with: data)

        tvName.text = data.merchant?.name
        guard let expiryDate = data.expiresAt else { return }
        lbExpireDate.text = "Expiry date: " + expiryDate
    }
    
    func getHeight(with merchant: Promotion) -> CGFloat {
        guard let text = merchant.merchant?.name else { return 0 }
        let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 2*lcsSideConstraintName.constant,
                                 font: UIFont(name: "SegoeUI-Semibold", size: 17)!)
        return height
    }
}
