//
//  PRForgotPasswordViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/10/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRForgotPasswordViewController: UIViewController {
    @IBOutlet weak var tfEmail              : UITextField!
    @IBOutlet weak var btnSubmit            : UIButton!
    
    let disposeBag                          = DisposeBag()
    var vm                                  = ForgotPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel() {
    
        _ = tfEmail.rx.text.map{ $0 ?? ""}.bind(to: vm.email)
        
        btnSubmit.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSubmitTapped)
            .disposed(by: disposeBag)
    }

}
