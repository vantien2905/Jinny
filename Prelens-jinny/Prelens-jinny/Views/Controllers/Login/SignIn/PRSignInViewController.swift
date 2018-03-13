//
//  PRSignInViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/7/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRSignInViewController: UIViewController {
    var parentNavigationController      : UINavigationController?
    var vm: SigninViewModel             = SigninViewModel()
    
    @IBOutlet weak var tfEmail          : UITextField!
    @IBOutlet weak var tfPassword       : UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
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
    }
    
    @IBAction func forgotPassBtnTapped(_ sender: Any) {
        let vc = PRForgotPasswordViewController.initControllerFromNib()
        self.push(controller: vc , animated: true)
    }

}
