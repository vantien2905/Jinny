//
//  Dropdown.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/27/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import UIKit

class Dropdown: PRBaseView, UITableViewDelegate, UITableViewDataSource {
    
    let btnCover: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    let tbView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    let lbTitle: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func setUpViews() {
        self.addSubview(btnCover)
        btnCover.addSubview(tbView)
        tbView.delegate = self
        tbView.dataSource = self
        btnCover.fillSuperview()
        tbView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
       
        cell.addSubview(lbTitle)
        lbTitle.fillSuperview()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
