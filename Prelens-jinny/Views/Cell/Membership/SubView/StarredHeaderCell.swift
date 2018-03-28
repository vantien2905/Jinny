//
//  StarredHeaderCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class StarredHeaderCell: UICollectionViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbTitle.font = PRFont.semiBold15
        lbTitle.textColor = PRColor.emptyMembership
    }

}
