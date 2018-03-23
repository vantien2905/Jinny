//
//  PickerPopupView.swift
//  Prelens-jinny
//
//  Created by vinova on 3/22/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    func numberOfRowsInComponent() -> Int
    func titleForRow(atIndex: Int) -> String
    func didSelectRow(atIndex: Int)
}

class PickerPopupView: BasePopUpView {
    static let shared = PickerPopupView()
    
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
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let vBottom: UIView = {
        let view = UIView()
        view.backgroundColor = PRColor.whiteColor
        
        return view
    }()
    weak var delegate: PickerViewDelegate?
    
    override func setupView() {
        super.setupView()
        pickerView.dataSource = self
        pickerView.delegate   = self
        vContent.addSubview(vTop)
        vTop.addSubview(btnDone)
        vContent.addSubview(vBottom)
        vBottom.addSubview(pickerView)
        
        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        pickerView.fillSuperview()
    }
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
    }
}
extension PickerPopupView:UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let _num = delegate?.numberOfRowsInComponent() else { return 0 }
        return _num
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let _title = delegate?.titleForRow(atIndex: row) else { return "" }
        return _title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        delegate?.didSelectRow(atIndex: row)
    }
}
