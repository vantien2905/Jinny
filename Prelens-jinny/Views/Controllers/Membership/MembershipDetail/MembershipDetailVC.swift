//
//  MembershipDetailVC.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class MembershipDetailVC: PRBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        setTitle(title: "STARBUCKS", textColor: UIColor.black, backgroundColor: .white)
        addBackButton()
        addStarButton()
    }

}
