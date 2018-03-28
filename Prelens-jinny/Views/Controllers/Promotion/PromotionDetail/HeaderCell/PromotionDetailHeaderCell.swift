//
//  PromotionDetailHeaderCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 19/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PromotionDetailHeaderCell: UICollectionViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 2
    }

    func setUpView(with data: PromotionDetail) {
        self.backgroundColor = .white
        lbName.isUserInteractionEnabled = false
        lbName.backgroundColor = .clear

        lbName.text = data.detailDescription
        guard let expiryDate = data.expireAtString else { return }
        lbExpireDate.text = "Expiry date: " + expiryDate
    }
    
//    func getHeight(with merchant: Promotion) -> CGFloat {
//        guard let text = merchant.merchant?.name else { return 0 }
////        let height = text.height(withConstrainedWidth: UIScreen.main.bounds.width - 2*lcsSideConstraintName.constant,
////                                 font: UIFont(name: "SegoeUI-Semibold", size: 17)!)
//        return height
//    }
}
