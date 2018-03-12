//
//  PRSignInViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/7/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRSignInViewController: UIViewController {
    var parentNavigationController      : UINavigationController?
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func forgotPassBtnTapped(_ sender: Any) {
        let vc = PRForgotPasswordViewController.initControllerFromNib()
        self.push(controller: vc , animated: true)
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
