//
//  MerchantDetailHeaderCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MerchantDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var imvMerchantAvatar: UIImageView!
    @IBOutlet weak var lcsImageAvatar: NSLayoutConstraint!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 2
        
    }

}
