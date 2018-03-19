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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnChangePasswordTapped(_ sender: Any) {
        let changePasswordVC = PRChangePassWordViewController.initControllerFromNib()
            self.push(controller: changePasswordVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
