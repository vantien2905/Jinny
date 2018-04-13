//
//  PrivacyViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 4/6/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PrivacyViewController: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "PRIVACY POLICY", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
