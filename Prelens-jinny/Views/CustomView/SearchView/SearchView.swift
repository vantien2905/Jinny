//
//  SearchView.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class SearchView: PRBaseViewXib {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBAction func btnSearchTapped() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    func setUpView() {
        tfSearch.borderStyle = .none
//        vContent.backgroundColor = PRColor.backgroundColor
    }
}
