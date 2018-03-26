//
//  PRSwitch.swift
//  Prelens-jinny
//
//  Created by vinova on 3/26/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift

class PRSwitch :PRBaseView {
    
    let vHorizontal: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    let imgCircle: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "circle")
        return img
    }()
    
    let btnAction: UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    var isCheck = Variable<Bool>(true)
     var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    override func setUpViews() {
        self.addSubview(vHorizontal)
        self.addSubview(imgCircle)
        self.addSubview(btnAction)
        
        vHorizontal.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        vHorizontal.centerSuperview()
        vHorizontal.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnAction.fillSuperview()
        btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
    }
    
    @objc func btnActionTapped() {
        if isCheck.value {
            vHorizontal.backgroundColor = UIColor.green
            UIView.animate(withDuration: 0.5, animations: {
                self.imgCircle.frame = CGRect(x: self.bounds.maxX - 26, y: self.bounds.minY + 0.5 , width: 22, height: 22)
                self.isCheck.value = false
            })
        } else {
            vHorizontal.backgroundColor = UIColor.gray
            UIView.animate(withDuration: 0.5, animations: {
                self.imgCircle.frame = CGRect(x: self.bounds.minX + 4 , y: self.bounds.minY + 0.5, width: 22, height: 22)
                self.isCheck.value = true
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgCircle.frame = CGRect(x: self.bounds.minX + 4, y: self.bounds.minY + 0.5 , width: 22, height: 22)
    }
}
