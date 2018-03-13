//
//  TestVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 12/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class TestVC: UIViewController {

    var testUser: APISignInService?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testUser = APISignInService()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTest(_ sender: Any) {
        testUser?.signIn(email: "lamp@vinova.sg",
                         password: "123456").subscribe({ (user) in
                print(user.element?.data?.getToken())
        })
    }
}
