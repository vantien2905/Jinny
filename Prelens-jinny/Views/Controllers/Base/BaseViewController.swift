//
//  BaseViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit
import Action
import Foundation

class PRBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        self.view.backgroundColor = PRColor.backgroundColor
    }
    
    func setTitle(title: String, textColor: UIColor = UIColor.white ) {
        let lb = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - self.view.bounds.width/4)/2, y: 0,
                                       width: self.view.bounds.width, height: 44))
        lb.font = UIFont(name: "OstrichSans-Heavy", size: 22.5)
        lb.text = title
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.textColor = textColor
        lb.sizeToFit()
        self.navigationItem.titleView = lb
    }
    
    func setTitle(title: String, textColor: UIColor = UIColor.white, backgroundColor: UIColor = PRColor.mainAppColor ) {
        let lb = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - self.view.bounds.width/4)/2, y: 0,
                                       width: self.view.bounds.width, height: 44))
        lb.font = UIFont(name: "OstrichSans-Heavy", size: 22.5)
        lb.text = title
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.textColor = textColor
        lb.sizeToFit()
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationItem.titleView = lb
    }
    
    func setUpLayout(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: CocoaAction) {
        var btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.rx.action = action
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func addStarButton() {
        self.addButtonToNavigation(image: PRImage.imgStar, style: .right, action: #selector(btnStarTapped))
    }
    
    func addBackButton() {
        self.addButtonToNavigation(image: PRImage.imgBack, style: .left, action: #selector(btnBackTapped))
    }
    
    @objc func btnStarTapped() {
        print("btn Star Tapped")
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
