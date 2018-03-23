//
//  AddMerchantCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class AddMerchantCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgMerchant: UIImageView!
    @IBOutlet weak var lbMemrchantName: UILabel!
    @IBOutlet weak var vBottom: UIView!
    
    var merchant: Merchant? {
        didSet {
            self.loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         self.selectionStyle = .none
    }
    
    func setUpView() {
        self.backgroundColor = PRColor.backgroundColor
        lbMemrchantName.backgroundColor = PRColor.backgroundColor
        vContent.backgroundColor = PRColor.backgroundColor
        vBottom.backgroundColor = PRColor.lineColor
        imgMerchant.layer.cornerRadius = 2.5
        imgMerchant.contentMode = .scaleAspectFit
        imgMerchant.layer.masksToBounds = true
        imgMerchant.backgroundColor = UIColor.white
    }
    
    func loadData() {
        guard let _merchant = merchant else { return }
        if let _name = _merchant.name {
            self.lbMemrchantName.text = _name
        }
        
        if let _logo = _merchant.logo, let _url = _logo.url, let _urlThump = _url.medium {
            let url = URL(string: _urlThump)
            imgMerchant.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
}
