//
//  TextFieldView.swift
//  Prelens-jinny
//
//  Created by vinova on 4/5/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
class TextFieldView: PRBaseViewXib {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var tfInput: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    func setUpView() {
         tfInput.borderStyle = .none
        vContent.layer.cornerRadius = 2.5
        vContent.layer.masksToBounds = true
        vContent.backgroundColor = .white
        vContent.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
    }
}
