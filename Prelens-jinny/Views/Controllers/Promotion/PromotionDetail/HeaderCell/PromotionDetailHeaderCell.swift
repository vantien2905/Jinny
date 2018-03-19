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
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        self.backgroundColor = .white
        
        tvName.isUserInteractionEnabled = false
        tvName.text = "Name of Merchant here....Name of Merchant here...."
        tvName.backgroundColor = .clear
        
    }
}
