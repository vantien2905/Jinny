//
//  MembershipCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MembershipCell: UICollectionViewCell {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgMemberShip: UIImageView!
    @IBOutlet weak var imgStar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }
    
    func setUpView() {
        vContent.layer.borderWidth = 0.5
        vContent.layer.borderColor = PRColor.lineColor.cgColor
    }

}
