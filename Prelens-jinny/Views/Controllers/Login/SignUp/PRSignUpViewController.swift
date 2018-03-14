//
//  PRLoginViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/5/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRSignUpViewController: UIViewController {
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var parentNavigationController      : UINavigationController?
    
    var vm: SignUpViewModel             = SignUpViewModel()
    let disposeBag                      = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapHideKeyboard()
        bindViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel() {
        _ = tfEmail.rx.text.map{ $0 ?? ""}.bind(to: vm.email)
        _ = tfPassword.rx.text.map{ $0 ?? ""}.bind(to: vm.password)
        vm.isValid.subscribe(onNext: { [weak self] isValid in
            print(isValid)
        }).disposed(by: disposeBag)
        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSignUpTapped)
            .disposed(by: disposeBag)
    }
}
