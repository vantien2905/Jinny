//
//  PRBaseView.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()

    }
    func setUpViews() {
        
    }


}
