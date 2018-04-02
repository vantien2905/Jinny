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

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
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
        tfPassword.isSecureTextEntry = true
        btnSignIn.layer.cornerRadius = 2.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(PRSignInViewController.gotoForgotPasswordVC))
        lbForgotPassword.isUserInteractionEnabled = true
        lbForgotPassword.addGestureRecognizer(tap)
        btnShowHidePassword.setImage(UIImage(named: "hidden"), for: .normal)
    }

    func bindViewModel() {
        _ = tfEmail.rx.text.map { $0 ?? ""}.bind(to: vm.email)
        _ = tfPassword.rx.text.map { $0 ?? ""}.bind(to: vm.password)
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

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: vm.btnSignInTapped)
            .disposed(by: disposeBag)

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfPassword.endEditing(true)
            }).disposed(by: disposeBag)

        btnSignIn.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.tfEmail.endEditing(true)
                self.tfPassword.endEditing(true)
            }).disposed(by: disposeBag)

        vm.isLoginSuccess.subscribe (onCompleted: {
            DispatchQueue.main.async {
                //if isGotoPassword {
                //    isGotoPassword = false
                //    self.dismiss(animated: true, completion: nil)
                //} else {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    appDelegate.goToMainApp()
                //}
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
