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
    
    @IBOutlet weak var tfPassword           : UITextField!
    @IBOutlet weak var tfEmail              : UITextField!
    @IBOutlet weak var btnSignUp            : UIButton!
    @IBOutlet weak var btnShowHidePassword  : UIButton!
    @IBOutlet weak var btnCheckConditions: UIButton!
    
    let disposeBag                          = DisposeBag()
    
    var parentNavigationController          : UINavigationController?
    var vm: SignUpViewModel                 = SignUpViewModel()
    var passIsSecurity                      :Bool?
    var conditionsIsChecked                 :Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapHideKeyboard()
        setupView()
        bindViewModel()
        // Do any additional setup after loading the view.
//        enumerateFonts()
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupView(){
        passIsSecurity = true
        conditionsIsChecked = false
    btnCheckConditions.setImage(UIImage(named:"check_box"), for: .normal)
        tfPassword.isSecureTextEntry = true
    btnShowHidePassword.setImage(UIImage(named:"hidden"), for: .normal)
    }
    
    func bindViewModel() {
        _ = tfEmail.rx.text.map{ $0 ?? ""}.bind(to: vm.email)
        _ = tfPassword.rx.text.map{ $0 ?? ""}.bind(to: vm.password)
        
        vm.email.asObservable().bind(to: tfEmail.rx.text).disposed(by: disposeBag)
        vm.password.asObservable().bind(to: tfPassword.rx.text).disposed(by: disposeBag)
        vm.isValid.subscribe(onNext: { [weak self] isValid in
           //TODO
        }).disposed(by: disposeBag)
        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSignUpTapped)
            .disposed(by: disposeBag)
        
        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfPassword.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func btnCheckConditionsTapped(_ sender: Any) {
        if(conditionsIsChecked == true) {
            btnCheckConditions.setImage(UIImage(named:"check_box_on"), for: .normal)
                conditionsIsChecked = false
        } else {
        btnCheckConditions.setImage(UIImage(named:"check_box"), for: .normal)
            conditionsIsChecked = true
        }
    }
    
    @IBAction func btnShowHidePasswordTapped(_ sender: Any) {
        if(passIsSecurity == true) {
            tfPassword.isSecureTextEntry = true
            btnShowHidePassword.setImage(UIImage(named:"hidden"), for: .normal)
            passIsSecurity = false
        } else {
            tfPassword.isSecureTextEntry = false
            btnShowHidePassword.setImage(UIImage(named:"visible"), for: .normal)
            passIsSecurity = true
        }
    }
}
