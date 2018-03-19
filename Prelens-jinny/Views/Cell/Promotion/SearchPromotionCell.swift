//
//  SearchMembershipCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class SearchPromotionCell: UICollectionViewCell {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var vSearch: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    func setUpView() {
        tfSearch.borderStyle = .none
        tfSearch.placeholder = "Search merchant"
        vSearch.layer.cornerRadius = 2.5
        vSearch.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        vSearch.dropShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 2.5, scale: true)
    }

}
