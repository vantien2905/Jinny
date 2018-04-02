//
//  PopUpYesNo.swift
//  Prelens-jinny
//
//  Created by Lamp on 30/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class PopUpYesNo: BasePopUpView {
    var completionYes: CompletionClosure?
    var completionNo: CompletionClosure?
    
    let lbContent: UILabel = {
        let lb              = UILabel()
        lb.textColor        = UIColor.black
        lb.numberOfLines    = 0
        lb.textAlignment    = .center
        return lb
    }()
    
    lazy var btnYes: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = UIColor.red
        btn.setAttributed(title: "Yes", color: UIColor.white, font: UIFont.boldSystemFont(ofSize: 15))
        btn.setBorder(cornerRadius: 5)
        btn.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnNo: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = UIColor.red
        btn.setAttributed(title: "No", color: UIColor.white, font: UIFont.boldSystemFont(ofSize: 15))
        btn.setBorder(cornerRadius: 5)
        btn.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        return btn
    }()
    
    override func setupView() {
        super.setupView()
        
        self.vContent.addSubview(lbContent)
        self.vContent.addSubview(btnYes)
        self.vContent.addSubview(btnNo)
        
        lbContent.centerXToSuperview()
        
        lbContent.anchor(vContent.topAnchor, left: vContent.leftAnchor,
                         bottom: btnYes.topAnchor, right: vContent.rightAnchor,
                         topConstant: 20, leftConstant: 20, bottomConstant: 20,
                         rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        btnYes.anchor(lbContent.bottomAnchor, left: vContent.leftAnchor,
                      bottom: vContent.bottomAnchor, right: btnNo.leftAnchor,
                      topConstant: 20, leftConstant: 8.5, bottomConstant: 13,
                      rightConstant: 8.5, widthConstant: (UIScreen.main.bounds.width/2) - 4, heightConstant: 40)
        btnNo.anchor(lbContent.bottomAnchor, left: btnYes.rightAnchor,
                     bottom: vContent.bottomAnchor, right: vContent.rightAnchor,
                     topConstant: 20, leftConstant: 8.5, bottomConstant: 13,
                     rightConstant: 8.5, widthConstant: (UIScreen.main.bounds.width/2) - 4, heightConstant: 40)
        btnNo.constraints.first?.priority = UILayoutPriority(rawValue: 999)
    }
    
    @objc func btnYesTapped() {
        self.hidePopUp()
        self.completionYes?()
    }
    
    @objc func btnNoTapped() {
        self.hidePopUp()
        self.completionNo?()
    }
    
    func showPopUp(message: String, completionYes: CompletionClosure? = nil, completionNo: CompletionClosure? = nil) {
        self.lbContent.text     = message
        self.completionYes      = completionYes
        self.completionNo       = completionNo
        showPopUp()
    }
    
    override func showPopUp(height: CGFloat = 150) {
        super.showPopUp(height: 150)
    }
}