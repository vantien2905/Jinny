//
//  PromotionDetailCell.swift
//  Prelens-jinny
//
//  Created by Lamp on 19/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import SDWebImage

class PromotionDetailCell: UICollectionViewCell {

    @IBOutlet weak var imvPromotionDetail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpView(with data: Image?) {
//        guard let urlString = data.image?.url?.medium, let url = URL(string: urlString) else { return }
        guard let imageURL = data?.url?.medium, let url = URL(string: imageURL) else { return }
        imvPromotionDetail.contentMode = .scaleAspectFit
        imvPromotionDetail.sd_setImage(with: url, placeholderImage: nil, options: .delayPlaceholder, completed: nil)
    }
}
