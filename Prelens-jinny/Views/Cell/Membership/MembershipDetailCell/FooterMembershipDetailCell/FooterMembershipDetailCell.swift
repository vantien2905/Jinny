//
//  FooterMembershipDetailCell.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/19/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
protocol FooterMembershipDetailCellDelegate: class {
    func isRemoveMembership()
}

class FooterMembershipDetailCell: UITableViewCell {

    weak var delegate: FooterMembershipDetailCellDelegate?
    @IBAction func btnRemoveTapped() {
        delegate?.isRemoveMembership()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
