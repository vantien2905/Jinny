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
    @IBOutlet weak var vContent: UIView!
    weak var delegate: FooterMembershipDetailCellDelegate?
    @IBAction func btnRemoveTapped() {
        delegate?.isRemoveMembership()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        vContent.backgroundColor = PRColor.backgroundColor
        self.backgroundColor = PRColor.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
