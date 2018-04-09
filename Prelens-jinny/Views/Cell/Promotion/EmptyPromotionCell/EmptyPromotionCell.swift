//
//  EmptyPromotionCell.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class EmptyPromotionCell: UICollectionViewCell {

    @IBOutlet weak var vLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    func setupView() {
        vLine.backgroundColor = PRColor.lineColor
    }
}
