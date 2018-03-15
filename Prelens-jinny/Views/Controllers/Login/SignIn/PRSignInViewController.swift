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
    var vm: SignInViewModel             = SignInViewModel()
    
    @IBOutlet weak var tfEmail          : UITextField!
    @IBOutlet weak var tfPassword       : UITextField!
    @IBOutlet weak var btnSignIn        : UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    let disposeBag                      = DisposeBag()
    var passIsSecurity                 :Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupView()
        bindViewModel()
        tfEmail.text = "felix@vinova.sg"
        tfPassword.text = "123456"
        bindViewModel()
        // Do any additional setup after loading the view.AEWFG
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        passIsSecurity = true
        tfPassword.isSecureTextEntry = true
        btnShowHidePassword.setImage(UIImage(named:"hidden"), for: .normal)
    }
    
    func bindViewModel() {
        _ = tfEmail.rx.text.map{ $0 ?? ""}.bind(to: vm.email)
        _ = tfPassword.rx.text.map{ $0 ?? ""}.bind(to: vm.password)
        vm.isValid.subscribe(onNext: { isValid in
            //TODO
        }).disposed(by: disposeBag)
        
        btnShowHidePassword.rx.tap
            .subscribe(onNext: {
                if(self.passIsSecurity == true) {
                    self.tfPassword.isSecureTextEntry = false
                    self.btnShowHidePassword.setImage(UIImage(named:"visible"), for: .normal)
                    self.passIsSecurity = false
                    } else {
                    self.tfPassword.isSecureTextEntry = true
                    self.btnShowHidePassword.setImage(UIImage(named:"hidden"), for: .normal)
                    self.passIsSecurity = true
            }
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

    @IBAction func forgotPassBtnTapped(_ sender: Any) {
        let vc = PRForgotPasswordViewController.initControllerFromNib()
        self.push(controller: vc , animated: true)
    }
}
