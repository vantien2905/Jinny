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
        img.image = UIImage(named: "switch-1")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let btnAction: UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    var isCheck = Variable<Bool>(false)
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let notificationType = UIApplication.shared.currentUserNotificationSettings?.types
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
        if notificationType?.rawValue != 0 {
            if isCheck.value == false {
                vHorizontal.backgroundColor = UIColor.green
                UIView.animate(withDuration: 0.15, animations: {
                    self.imgCircle.frame = CGRect(x: self.bounds.maxX - 28, y: self.bounds.minY + 1.5, width: 22, height: 22)
                    self.isCheck.value = true
                })
            } else {
                vHorizontal.backgroundColor = UIColor.gray
                UIView.animate(withDuration: 0.15, animations: {
                self.imgCircle.frame = CGRect(x: self.bounds.minX + 6 , y: self.bounds.minY + 1.5, width: 22, height: 22)
                self.isCheck.value = false
                })
            }
        } else {
            PopUpHelper.shared.showMessage(message: ContantMessages.Setting.errorUnauthorized)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isCheck.value {
            vHorizontal.backgroundColor = UIColor.green
            self.imgCircle.frame = CGRect(x: self.bounds.maxX - 28, y: self.bounds.minY + 1.5 , width: 22, height: 22)
            
        } else {
            vHorizontal.backgroundColor = UIColor.gray
            imgCircle.frame = CGRect(x: self.bounds.minX + 6, y: self.bounds.minY + 1.5 , width: 22, height: 22)
        }
    }
}
