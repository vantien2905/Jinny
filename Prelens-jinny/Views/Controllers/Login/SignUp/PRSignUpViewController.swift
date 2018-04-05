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

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var btnCheckConditions: UIButton!

    let disposeBag                          = DisposeBag()

    var parentNavigationController: UINavigationController?
    var vm: SignUpViewModel                 = SignUpViewModel()
    var passIsSecurity: Bool?
    var conditionsIsChecked: Bool?
    var isChecked                           = Variable<Bool>(false)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapHideKeyboard()
        setupView()
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupView() {
        passIsSecurity = true
        conditionsIsChecked = false
        tfPassword.isSecureTextEntry = true
        btnSignUp.layer.cornerRadius = 2.5
        btnCheckConditions.setImage(UIImage(named: "check_box"), for: .normal)
        btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
    }

    func bindViewModel() {
        _ = tfEmail.rx.text.map { $0 ?? ""}.bind(to: vm.email)
        _ = tfPassword.rx.text.map { $0 ?? ""}.bind(to: vm.password)
        //_ = isChecked.asObservable().bind(to: vm.isChecked)
        vm.email.asObservable().bind(to: tfEmail.rx.text).disposed(by: disposeBag)
        vm.password.asObservable().bind(to: tfPassword.rx.text).disposed(by: disposeBag)
        vm.isValid.subscribe(onNext: { _ in
           //TODO
        }).disposed(by: disposeBag)

        btnShowHidePassword.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self, let _passIsSecurity = strongSelf.passIsSecurity else { return }
                if(_passIsSecurity == true) {
                    strongSelf.btnShowHidePassword.setImage(UIImage(named: "visible"), for: .normal)
                } else {
                    strongSelf.btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
                }
                strongSelf.tfPassword.isSecureTextEntry = !(_passIsSecurity)
                strongSelf.passIsSecurity = !(_passIsSecurity)
            }).disposed(by: disposeBag)

        btnCheckConditions.rx.tap
            .subscribe(onNext: {
                if(self.conditionsIsChecked == true) {
                    self.btnCheckConditions.setImage(UIImage(named: "check_box"), for: .normal)
                    self.conditionsIsChecked = false

                } else {
                    self.btnCheckConditions.setImage(UIImage(named: "check_box_on"), for: .normal)
                    self.conditionsIsChecked = true
                }
                self.isChecked.value = self.conditionsIsChecked!
                _ = self.isChecked.asObservable().bind(to: self.vm.isChecked)
            }).disposed(by: disposeBag)

        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSignUpTapped)
            .disposed(by: disposeBag)

        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfEmail.endEditing(true)
                self.tfPassword.endEditing(true)
            }).disposed(by: disposeBag)
        
        vm.isSignUpSuccess.subscribe (onCompleted: {
            LocalNotification.setupSettingStatus()
            DispatchQueue.main.async {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                appDelegate.goToMainApp()
            }
        }).disposed(by: disposeBag)
    }
}
