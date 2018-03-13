//
//  PopUpView.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class PopUpView: BasePopUpView {
    var completion: CompletionClosure?
    
    let lbContent: UILabel = {
        let lb              = UILabel()
        lb.textColor        = UIColor.black
        lb.numberOfLines    = 0
        lb.textAlignment    = .center
        return lb
    }()
    
    lazy var btnOK: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = UIColor.red
        btn.setAttributed(title: "OK", color: UIColor.white, font: UIFont.boldSystemFont(ofSize: 15))
        btn.setBorder(cornerRadius: 5)
        btn.addTarget(self, action: #selector(btnOkTapped), for: .touchUpInside)
        return btn
    }()
    
    override func setupView() {
        super.setupView()
        
        self.vContent.addSubview(lbContent)
        self.vContent.addSubview(btnOK)
        
        lbContent.centerXToSuperview()
        
        lbContent.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: btnOK.topAnchor, right: vContent.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        btnOK.anchor(lbContent.bottomAnchor, left: vContent.leftAnchor, bottom: vContent.bottomAnchor, right: vContent.rightAnchor, topConstant: 20, leftConstant: 8.5, bottomConstant: 13, rightConstant: 8.5, heightConstant: 40)
        btnOK.addTarget(self, action: #selector(btnOkTapped), for: .touchUpInside)
    }
    
    @objc func btnOkTapped() {
        self.hidePopUp()
        self.completion?()
    }
    
    func showPopUp(message: String, completion: CompletionClosure? = nil) {
        self.lbContent.text     = message
        self.completion         = completion
        showPopUp()
    }
    
    override func showPopUp(height: CGFloat = 250) {
        super.showPopUp(height: 250)
    }
}

