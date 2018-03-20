//
//  AddManualViewController.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class AddManualViewController: BaseViewController {

    @IBOutlet weak var tfSerial: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var vHeader: UIView!
    
    @IBAction func btnDoneTapped() {
        
    }
    
    @IBAction func btnBackClick() {
        self.pop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigation()
        darkStatus()
    }

    func setUpView() {
        vHeader.setShadow()
    }
}
