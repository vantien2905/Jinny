//
//  OtherHeaderCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol OtherHeaderCellDelegate: class {
    func sortTapped()
}

class OtherHeaderCell: UICollectionViewCell {

    @IBOutlet weak var lbSortBy: UILabel!
    @IBOutlet weak var lbLatest: UILabel!
    @IBOutlet weak var lbOther: UILabel!
    @IBOutlet weak var vSort: UIView!
    
    weak var delegate: OtherHeaderCellDelegate?
    
    @IBAction func btnSortTapped() {
        delegate?.sortTapped()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        vSort.backgroundColor = PRColor.backgroundColor
        lbOther.font = PRFont.semiBold15
        lbLatest.textAlignment = .center
    }

}
