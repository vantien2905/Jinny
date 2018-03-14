//
//  MembershipFooterCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MembershipFooterCell: UICollectionViewCell {

    @IBOutlet weak var vLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    func setUpView() {
        vLine.backgroundColor = PRColor.lineColor
    }
}
