//
//  SortPopUpView.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/27/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class SortPopUpView: BasePopUpView {
    var completionLatest: CompletionClosure?
    var completionEarliest: CompletionClosure?
    
    let lbContent: UILabel = {
        let lb              = UILabel()
        lb.textColor        = UIColor.black
        lb.numberOfLines    = 0
        lb.textAlignment    = .center
        return lb
    }()
    
    lazy var btnLatest: UIButton = {
        let btn             = UIButton()
        btn.setAttributed(title: "Latest", color: UIColor.red, font: UIFont.boldSystemFont(ofSize: 15))
        btn.setBorder(cornerRadius: 5)
        btn.addTarget(self, action: #selector(btnLatestTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnEarliest: UIButton = {
        let btn             = UIButton()
        btn.setAttributed(title: "Earliest", color: UIColor.red, font: UIFont.boldSystemFont(ofSize: 15))
        btn.setBorder(cornerRadius: 5)
        btn.addTarget(self, action: #selector(btnEarliestTapped), for: .touchUpInside)
        return btn
    }()
    
    override func setupView() {
        super.setupView()
        
        self.vContent.addSubview(lbContent)
        self.vContent.addSubview(btnLatest)
        self.vContent.addSubview(btnEarliest)
        lbContent.isHidden = true
        lbContent.centerXToSuperview()
        
        lbContent.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: btnLatest.topAnchor, right: vContent.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        btnLatest.anchor(lbContent.bottomAnchor, left: vContent.leftAnchor, right: vContent.rightAnchor, topConstant: 20, leftConstant: 8.5, rightConstant: 8.5, heightConstant: 40)
        btnEarliest.anchor(btnLatest.bottomAnchor, left: vContent.leftAnchor, right: vContent.rightAnchor, topConstant: 20, leftConstant: 8.5, rightConstant: 8.5, heightConstant: 40)
        
//        btnLatest.addTarget(self, action: #selector(btnLatestTapped), for: .touchUpInside)
//        btnLatest.addTarget(self, action: #selector(btnEarliestTapped), for: .touchUpInside)
    }
    
    @objc func btnLatestTapped() {
        self.hidePopUp()
        self.completionLatest?()
    }
    
    @objc func btnEarliestTapped() {
        self.hidePopUp()
        self.completionEarliest?()
    }
    
    func showPopUp(message: String, completionLatest: CompletionClosure? = nil, completionEarliest: CompletionClosure? = nil) {
        self.lbContent.text     = message
        self.completionLatest   = completionLatest
        self.completionEarliest = completionEarliest
        showPopUp()
    }
    
    override func showPopUp(height: CGFloat = 500) {
        super.showPopUp(height: 250)
    }
}
