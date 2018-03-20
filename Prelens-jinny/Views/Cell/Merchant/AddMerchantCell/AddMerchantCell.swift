//
//  AddMerchantCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class AddMerchantCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgMerchant: UIImageView!
    @IBOutlet weak var lbMemrchantName: UILabel!
    @IBOutlet weak var vBottom: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpView() {
        self.backgroundColor = PRColor.backgroundColor
        lbMemrchantName.backgroundColor = PRColor.backgroundColor
        vContent.backgroundColor = PRColor.backgroundColor
        vBottom.backgroundColor = UIColor.gray
        imgMerchant.layer.cornerRadius = 2.5
    }
    
}
