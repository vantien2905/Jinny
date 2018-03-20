//
//  ScanCodeViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class ScanCodeViewController: BaseViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbAddManual: UILabel!
    @IBAction func btnAddManuallyTapped() {
        let vcAddManual = AddManualViewController.initControllerFromNib()
        self.push(controller: vcAddManual, animated: true)
    }
    
    @IBAction func btnBackClick() {
        self.pop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        lbAddManual.backgroundColor = PRColor.backgroundColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
    }

}
