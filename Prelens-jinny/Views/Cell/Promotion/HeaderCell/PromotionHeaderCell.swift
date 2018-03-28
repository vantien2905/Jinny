//
//  PromotionHeaderCell.swift
//  Prelens-jinny
//
//  Created by vinova on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PromotionSortDelegate: class {
    func sortTapped()
}

class PromotionHeaderCell: UICollectionViewCell {
    @IBOutlet weak var vFilter: UIView!
    @IBOutlet weak var lbSort: UILabel!
    
    weak var delegate: PromotionSortDelegate?
    @IBAction func btnSortTapped(_ sender: Any) {
        print("aaa")
        delegate?.sortTapped()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
