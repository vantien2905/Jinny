//
//  RedeemCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 9/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class RedeemCell: UICollectionViewCell {

    @IBOutlet weak var imvQRCode: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setData(data: PromotionDetail) {
        imvQRCode.contentMode = .scaleAspectFit
        guard let imgString = data.qrCode?.url?.original, let url = URL(string: imgString) else { return }
        imvQRCode.sd_setImage(with: url, completed: nil)
    }
}
