//
//  AddMerchantViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class AddMerchantViewController: BaseViewController {

    @IBOutlet weak var vSearch: SearchView!
    @IBOutlet weak var tbMerchant: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUpView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigation()
        darkStatus()
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
        self.navigationController?.navigationBar.setShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigation()
        
    }

    func setUpView() {
        vSearch.setShadow(color: PRColor.lineColor, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 2.5, scale: true)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        setTitle(title: "ADD MEMBERSHIP", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    
    func configureTableView() {
        tbMerchant.register(UINib(nibName: Cell.addMerchantCell, bundle: nil), forCellReuseIdentifier: Cell.addMerchantCell)
        tbMerchant.delegate = self
        tbMerchant.dataSource = self
        tbMerchant.backgroundColor = PRColor.backgroundColor
    }
}

extension AddMerchantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.addMerchantCell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcScancode = ScanCodeViewController.initControllerFromNib()
        self.push(controller: vcScancode, animated: true)
    }
}
