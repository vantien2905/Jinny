//
//  RedeemVoucherFooterCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 30/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol RedeemVoucherFooterCellButtonDelegate: class {
    func btnRedeemedTapped()
}

class RedeemVoucherFooterCell: UICollectionViewCell {
    @IBOutlet weak var lbText: UILabel!
    @IBOutlet weak var btnRedeem: UIButton!
    
    weak var btnRedeemedDelegate: RedeemVoucherFooterCellButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        let attr = PRHelper.setNSMutableAttributedString(text: "Click to redeem", font: PRFont.semiBold15!, foregroundColor: .white)
        let attr1 = PRHelper.setNSAttributedString(text: "\n Note: for", font: PRFont.regular15!, foregroundColor: .white)
        let attr2 = PRHelper.setNSMutableAttributedString(text: " merchants", font: PRFont.semiBold15!, foregroundColor: .white)
        let attr3 = PRHelper.setNSAttributedString(text: " only", font: PRFont.regular15!, foregroundColor: .white)
        
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        lbText.attributedText = attr
        
    }
    //Add delegate to show popup in the viewcontroller
    @IBAction func btnRedeemTapped() {
        btnRedeemedDelegate?.btnRedeemedTapped()
    }
}
