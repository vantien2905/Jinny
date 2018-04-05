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
    var parentNavigationController: UINavigationController?
    var vm: SignInViewModel = SignInViewModel()
    
    @IBOutlet weak var vEmail: TextFieldView!
    @IBOutlet weak var vPassword: TextFieldView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var lbForgotPassword: UILabel!
    let disposeBag                      = DisposeBag()
    var passIsSecurity: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupView()
        bindViewModel()
        // Do any additional setup after loading the view.AEWFG
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupView() {
        hideKeyboard()
        passIsSecurity = true
        vPassword.tfInput.isSecureTextEntry = true
        btnSignIn.layer.cornerRadius = 2.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(PRSignInViewController.gotoForgotPasswordVC))
        lbForgotPassword.isUserInteractionEnabled = true
        lbForgotPassword.addGestureRecognizer(tap)
        btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
    }

    func bindViewModel() {
        _ = vEmail.tfInput.rx.text.map { $0 ?? ""}.bind(to: vm.email)
        _ = vPassword.tfInput.rx.text.map { $0 ?? ""}.bind(to: vm.password)
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
                strongSelf.vPassword.tfInput.isSecureTextEntry = !(_passIsSecurity)
                strongSelf.passIsSecurity = !(_passIsSecurity)
        }).disposed(by: disposeBag)

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSignInTapped)
            .disposed(by: disposeBag)

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vPassword.tfInput.endEditing(true)
            }).disposed(by: disposeBag)

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.vEmail.tfInput.endEditing(true)
                self.vPassword.tfInput.endEditing(true)
            }).disposed(by: disposeBag)

        vm.isLoginSuccess.subscribe (onCompleted: {
            LocalNotification.setupSettingStatus()
            DispatchQueue.main.async {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                appDelegate.goToMainApp()
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func gotoForgotPasswordVC(){
        let vc = PRForgotPasswordViewController.initControllerFromNib()
        self.push(controller: vc, animated: true)
    }
    
    @IBAction func forgotPassBtnTapped(_ sender: Any) {
       gotoForgotPasswordVC()
    }
}
