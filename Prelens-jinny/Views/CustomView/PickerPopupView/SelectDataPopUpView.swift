//
//  TablePopUpView.swift
//  Prelens-jinny
//
//  Created by vinova on 3/23/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol SelectDataPopUpViewDelegate: class {
    func numberOfRows() -> Int
    func titleForRow(index: Int) -> String
    func didSelectRow(index: Int)
}

class SelectDataPopUpView: BasePopUpView {

    static let shared = SelectDataPopUpView()
    var index:Int?
    let vTop: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.red
    return view
    }()
    
    let vBottom: UIView = {
        let view = UIView()
        view.backgroundColor = PRColor.whiteColor
        
        return view
    }()
    
    let tbvData : UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        return tableview
    }()
    
    let btnDone: UIButton = {
        let btn = UIButton()
        btn.setAttributed(title: "Done", color: PRColor.whiteColor, font: PRFont.semiBold15)
        btn.addTarget(self, action: #selector(btnDoneTapped), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
        guard let _index = index else {return}
        delegate?.didSelectRow(index: _index)
    }
    
    weak var delegate: SelectDataPopUpViewDelegate?
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vTop)
        vContent.addSubview(vBottom)
        vBottom.addSubview(tbvData)
        vTop.addSubview(btnDone)
        configTableView()
         vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tbvData.fillSuperview()
    }
    
    func configTableView() {
        tbvData.separatorInset = .zero
        tbvData.layoutMargins = .zero
        tbvData.dataSource = self
        tbvData.delegate = self
        tbvData.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tbvData.frame.size.width, height: 1))
        tbvData.register(UINib(nibName: Cell.selectDataCell, bundle: nil), forCellReuseIdentifier: Cell.selectDataCell)
    }
}
extension SelectDataPopUpView:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _num = delegate?.numberOfRows() else { return 0 }
        return _num
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvData.dequeueReusableCell(withIdentifier: Cell.selectDataCell, for: indexPath) as! SelectDataPopUpCell
        cell.lbTitle.text = delegate?.titleForRow(index: indexPath.row).cutWhiteSpace()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
    }
}
