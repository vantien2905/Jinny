//
//  SignUpViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 14/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

final class SignUpViewModel {
    private var disposeBag = DisposeBag()

    public var email: Variable<String?>
    public var password: Variable<String?>
    public var isValidInput: Variable<Bool>
    private var userSignUp          = Variable<PRUser?>(nil)
    public var btnSignUpTapped: PublishSubject<Void>
    public var isChecked: Variable<Bool>
    public var isLoginSuccess: PublishSubject<Bool>

    var isValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) { email, password in email!.count > 0 && password!.count > 0
        }
    }

    init() {
        self.email = Variable<String?>(nil)
        self.password = Variable<String?>(nil)
        self.isValidInput = Variable<Bool>(false)
        self.isChecked = Variable<Bool>(false)
        self.btnSignUpTapped = PublishSubject<Void>()
        self.isLoginSuccess = PublishSubject<Bool>()

        _ = isChecked.asObservable().subscribe(onNext: { _ in
            //TODO
        })

        let isValid = self.checkValid(emailText: email.asObservable(), passwordText: password.asObservable())

        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)

        self.btnSignUpTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let pass = strongSelf.password.value else {
               print("error")
               return
            }
            if pass.isValidPassword() {
                if self?.isValidInput.value == false {
                    PopUpHelper.shared.showMessage(message: "Please enter your email & password")
                } else if self?.isChecked.value == false {
                    PopUpHelper.shared.showMessage(message: "Please indicate that you have agree to the Terms and Conditions")
                } else {
                    strongSelf.callAPISignUp()
                }
            } else {
                PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorContentPassword)
            }
        }).disposed(by: disposeBag)
    }

    func checkValid(emailText: Observable<String?>, passwordText: Observable<String?>) -> Observable<Bool> {
        return Observable.combineLatest(emailText, passwordText) {(email, password) -> Bool in
            guard let _email = email, let _password = password else {
                return false
            }
            return  ( !_email.isValidEmpty() && !_password.isValidEmpty())
        }
    }

    func callAPISignUp() {
        guard let email = self.email.value, let pass = self.password.value else { return }
        Provider.shared.authenticationService.signUp(email: email, password: pass)
            .subscribe(onNext: { [weak self] (user) in
                guard let strongSelf = self else { return }
                strongSelf.userSignUp.value = user
                PopUpHelper.shared.showMessage(message: "Sign up success!")
                strongSelf.resetUI()
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }

    func resetUI() {
        self.email.value = ""
        self.password.value = ""
    }
}
