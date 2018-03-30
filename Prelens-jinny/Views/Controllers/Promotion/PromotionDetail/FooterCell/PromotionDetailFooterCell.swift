//
//  PromotionDetailFooterCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 19/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PromotionDetailFooterCellDelegate: class {
    func btnRemoveTapped()
}

class PromotionDetailFooterCell: UICollectionViewCell {

    weak var btnRemoveDelegate: PromotionDetailFooterCellDelegate?
    
    @IBOutlet weak var btnRemoveVoucher: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func btnRemoveTapped() {
        btnRemoveDelegate?.btnRemoveTapped()
    }
}
