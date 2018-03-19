//
//  SettingViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/17/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Setting", textColor: .black, backgroundColor: .white)
        addBackButton()
    }

    @IBAction func btnChangePasswordTapped(_ sender: Any) {
        let changePasswordVC = PRChangePassWordViewController.initControllerFromNib()
        self.push(controller: changePasswordVC)
    }
 
}
