//
//  ChooseDatePopupView.swift
//  Prelens-jinny
//
//  Created by vinova on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol ChooseDatePopUpViewDelegate: class {
    func selectedDate(date: Date)
}

class ChooseDatePopupView: BasePopUpView {
    static let shared = ChooseDatePopupView()
    
    let vTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let btnDone: UIButton = {
        let btn = UIButton()
        btn.setAttributed(title: "Done", color: PRColor.whiteColor, font: PRFont.semiBold15)
        btn.addTarget(self, action: #selector(btnDoneTapped), for: .touchUpInside)

        return btn
    }()
    
    let vBottom: UIView = {
        let view = UIView()
        view.backgroundColor = PRColor.whiteColor
        
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.locale = Locale(identifier: "en_SG")
        date.datePickerMode = UIDatePickerMode.date
        //date.setValue(NCSColor.whiteColor, forKey: "textColor")
        
        return date
    }()
    weak var delegate: ChooseDatePopUpViewDelegate?
    override func setupView() {
        super.setupView()
        vContent.addSubview(vTop)
        vTop.addSubview(btnDone)
        vContent.addSubview(vBottom)
        vBottom.addSubview(datePicker)
        
        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        datePicker.fillSuperview()
    }
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
        let dateSelected = datePicker.date
        delegate?.selectedDate(date: dateSelected)
    }
}
