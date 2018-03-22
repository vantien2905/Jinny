//
//  PRLoadingView.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/22/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

import UIKit

class PRLoadingView: PRBaseView {
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        aiv.startAnimating()
        return aiv
    }()
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear 
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        blackView.addSubview(activityIndicator)
        activityIndicator.centerSuperview()
    }
    
    func showActivityIndicator() {
        if let vc = UIApplication.topViewController() {
            vc.view.endEditing(true)
        }
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.fillSuperview()
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.blackView.removeFromSuperview()
        }
    }
}
