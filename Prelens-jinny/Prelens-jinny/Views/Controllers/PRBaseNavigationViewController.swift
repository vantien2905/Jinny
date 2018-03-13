//
//  PRBaseNavigationViewController.swift
//  Prelens-jinny
//
//  Created by Lamp on 8/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import Foundation

class PRBaseNavigationViewController: UIViewController {
    let btnLeft: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 40)
        btn.setImage(#imageLiteral(resourceName: "back_black"), for: .normal)
        btn.imageView?.contentMode = .scaleToFill
        btn.titleLabel?.font = UIFont(name: "Lato-Bold", size: 17.5)
        btn.contentHorizontalAlignment = .left
        
        return btn
    }()
    
    let btnRight: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        btn.imageView?.contentMode = .scaleToFill
        btn.titleLabel?.font = UIFont(name: "Lato-Bold", size: 17.5)
        btn.contentHorizontalAlignment = .right
        
        return btn
    }()
    let viewSearch: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    /*
     let txtSearch: UITextField = {
     let textField = UITextField()
     textField.placeholder =  CPConstantTitles.LabelTitle.search
     textField.textColor = .white
     textField.font = UIFont(name: "Lato-Regular", size: 17.5)
     textField.attributedPlaceholder = NSAttributedString(string: CPConstantTitles.LabelTitle.search,
     attributes: [NSForegroundColorAttributeName : UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.5)])
     return textField
     }() */
    
    let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    var isSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()

    }
    
    func setTitle(title: String, textColor: UIColor = UIColor.white ) {
        let lb = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - self.view.bounds.width/4)/2, y: 0,
                                       width: self.view.bounds.width, height: 44))
        lb.font = UIFont(name: "OstrichSans-Heavy", size: 30)
        lb.text = title
        lb.textAlignment = .center
        lb.numberOfLines = 2
        lb.textColor = textColor
        lb.sizeToFit()
        
        self.navigationItem.titleView = lb
    }
    
    func setUpLayout(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = PRColor.mainAppColor
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
        //---
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnLeft)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnRight)
        self.view.backgroundColor = UIColor.yellow //    UIColor.mainBackGroundApp()
        //--
        setUpViewSearch()
        //---add target for button
        btnLeft.addTarget(self, action: #selector(btnLeftTapped), for: .touchUpInside)
        btnRight.addTarget(self, action: #selector(btnRightTapped), for: .touchUpInside)
        
        //        txtSearch.delegate = self
    }
    
    func setUpViewSearch(){
        //        self.navigationItem.titleView = viewSearch
        //        // width = self.view.frame.width - 60 width 2 button left right - 8 leading and 8 trailing
        //        viewSearch.frame = CGRect(x: 8, y: 0, width: (self.navigationController?.navigationBar.frame.width)! - 72, height: 44)
        //
        //        self.viewSearch.addSubview(viewLine)
        //        viewLine.frame = CGRect(x: 8, y: 40, width: self.viewSearch.frame.width - 8, height: 1)
        //
        //        self.viewSearch.addSubview(txtSearch)
        //        txtSearch.frame = CGRect(x: 16, y: 0, width: self.viewSearch.frame.width - 44 , height: 40)
    }
    
    //:MARK  -- button tapped
    @objc func btnLeftTapped(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc final func btnRightTapped(){
        if isSearch {
            //            txtSearch.becomeFirstResponder()
            //        } else {
            //            txtSearch.text = nil
            //            hideClose()
        }
    }
    
    //:MARK --- method for Button hide show ,setTitle button
    func hideLeftButton(){
        self.btnLeft.isHidden = true
        viewLine.frame = CGRect(x: 8 - 40, y: 40, width: self.viewSearch.frame.width - 8 + 40, height: 1)
        //  txtSearch.frame = CGRect(x: 16 - 40 , y: 0, width: self.viewSearch.frame.width - 44 + 40 , height: 40)
    }
    
    func hideTextFieldSearch(){
        viewSearch.isHidden = true
    }
    
    func setTitleLeftButton(title: String){
        btnLeft.setImage(nil, for: .normal)
        btnLeft.setTitle(title, for: UIControlState.normal)
        btnLeft.frame = CGRect(x: 0, y: 0, width: 70, height: 21)
        //        btnLeft.frame = CGRect(x: 0, y: 0, width: 17*title.length, height: 21)
        
    }
    
    func setTitleRightButton(title: String){
        btnRight.setImage(nil, for: .normal)
        btnRight.setTitle(title, for: UIControlState.normal)
        btnRight.frame = CGRect(x: 0, y: 0, width: 70, height: 21)
        
    }
    
    func setColorTitleLeftButton(color: UIColor){
        btnLeft.setTitleColor(color, for: .normal)
    }
}
