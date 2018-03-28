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
    @IBOutlet weak var vSupper: UIView!
    @IBAction func btnSearchTapped() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    func setUpView() {
        tfSearch.borderStyle = .none
        vContent.layer.cornerRadius = 2.5
        vContent.layer.masksToBounds = true
        vContent.backgroundColor = .white
        vSupper.backgroundColor = .clear
        vContent.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
//        self.backgroundColor = PRColor.backgroundColor
    }
}
