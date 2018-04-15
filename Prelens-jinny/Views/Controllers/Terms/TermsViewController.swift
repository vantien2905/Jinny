//
//  TermsViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 4/6/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class TermsViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "TERMS AND CONDITIONS", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        
    }
}
