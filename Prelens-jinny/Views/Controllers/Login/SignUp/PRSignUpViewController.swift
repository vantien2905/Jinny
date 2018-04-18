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
    
    @IBOutlet weak var vPassword: TextFieldView!
    @IBOutlet weak var vEmail: TextFieldView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var btnCheckConditions: UIButton!
    @IBOutlet weak var btnGuestLogin: UIButton!
    
    let disposeBag                          = DisposeBag()

    var parentNavigationController: UINavigationController?
    var viewModel: SignUpViewModelProtocol!
    var passIsSecurity: Bool?
    var conditionsIsChecked: Bool?
    var isChecked                           = Variable<Bool>(false)

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
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
        vPassword.tfInput.isSecureTextEntry = true
        btnSignUp.layer.cornerRadius = 2.5
        btnCheckConditions.setImage(UIImage(named: "check_box"), for: .normal)
        btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
    }
    
    class func configureViewController() -> PRSignUpViewController {
        let signUpVC = PRSignUpViewController.initControllerFromNib() as! PRSignUpViewController
        var viewModel: SignUpViewModel {
            return SignUpViewModel()
        }
        signUpVC.viewModel = viewModel
        return signUpVC
    }
    
    func bindViewModel() {
        _ = vEmail.tfInput.rx.text.map { $0 ?? ""}.bind(to: viewModel.email)
        _ = vPassword.tfInput.rx.text.map { $0 ?? ""}.bind(to: viewModel.password)
        viewModel.email.asObservable().bind(to: vEmail.tfInput.rx.text).disposed(by: disposeBag)
        viewModel.password.asObservable().bind(to: vPassword.tfInput.rx.text).disposed(by: disposeBag)
        viewModel.isValid.subscribe(onNext: { _ in
           //TODO
        }).disposed(by: disposeBag)

        btnShowHidePassword.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self, let _passIsSecurity = strongSelf.passIsSecurity else { return }
                if _passIsSecurity == true {
                    strongSelf.btnShowHidePassword.setImage(UIImage(named: "visible"), for: .normal)
                } else {
                    strongSelf.btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
                }
                strongSelf.vPassword.tfInput.isSecureTextEntry = !(_passIsSecurity)
                strongSelf.passIsSecurity = !(_passIsSecurity)
            }).disposed(by: disposeBag)

        btnCheckConditions.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                if strongSelf.conditionsIsChecked == true {
                    strongSelf.btnCheckConditions.setImage(UIImage(named: "check_box"), for: .normal)
                    strongSelf.conditionsIsChecked = false

                } else {
                    strongSelf.btnCheckConditions.setImage(UIImage(named: "check_box_on"), for: .normal)
                    strongSelf.conditionsIsChecked = true
                }
                strongSelf.isChecked.value = strongSelf.conditionsIsChecked!
                _ = strongSelf.isChecked.asObservable().bind(to: strongSelf.viewModel.isChecked)
            }).disposed(by: disposeBag)

        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnSignUpTapped)
            .disposed(by: disposeBag)

        btnSignUp.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vEmail.tfInput.endEditing(true)
                self.vPassword.tfInput.endEditing(true)
            }).disposed(by: disposeBag)
        
        btnGuestLogin.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnGuestLoginTapped)
            .disposed(by: disposeBag)
        
        btnGuestLogin.rx.tap
            .subscribe(onNext: {
                print(UIDevice.current.identifierForVendor!.uuidString)
            }).disposed(by: disposeBag)
        
        viewModel.isSignUpSuccess.subscribe (onCompleted: {
            LocalNotification.setupSettingStatus()
            DispatchQueue.main.async {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                appDelegate.goToMainApp()
            }
        }).disposed(by: disposeBag)
    }
}
