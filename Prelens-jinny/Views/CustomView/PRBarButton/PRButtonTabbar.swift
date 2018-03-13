//
//  PRButtonTabbar.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRButtonTabbar: PRBaseView {

    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lbCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbCounter.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 2.5)
        
    }



}
