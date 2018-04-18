//
//  SignUpViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 14/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa
protocol SignUpViewModelProtocol{
    var email: Variable<String?>{get set}
    var password: Variable<String?>{get set}
    var isValidInput: Variable<Bool>{get}
    var userSignUp:Variable<PRUser?>{get}
    var btnSignUpTapped: PublishSubject<Void>{get}
    var isChecked: Variable<Bool>{get}
    var isSignUpSuccess: PublishSubject<Bool>{get}
    var isValid: Observable<Bool>{get}
    func callAPISignUp()
}
final class SignUpViewModel:SignUpViewModelProtocol {
    private var disposeBag = DisposeBag()

    var email: Variable<String?>
    var password: Variable<String?>
    var isValidInput: Variable<Bool>
    var userSignUp = Variable<PRUser?>(nil)
    var btnSignUpTapped: PublishSubject<Void>
    var isChecked: Variable<Bool>
    var isSignUpSuccess: PublishSubject<Bool>

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
        self.isSignUpSuccess = PublishSubject<Bool>()
        
        _ = isChecked.asObservable().subscribe(onNext: { _ in
            //todo
        })

        let isValid = self.checkValid(emailText: email.asObservable(), passwordText: password.asObservable())

        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)
        
        self.signUpTapped()
        userSignUp.asObservable()
            .ignoreNil()
            .subscribe(onNext: {  [weak self] userSignUp in
                guard let strongSelf = self else { return }
                let defaults = UserDefaults.standard
                if let token = userSignUp.token {
                    KeychainManager.shared.saveString(value: strongSelf.email.value&, forkey: .email)
                    KeychainManager.shared.setToken(token)
                    KeychainManager.shared.saveString(value: "7", forkey: KeychainItem.leftDayToRemind)
                }
                defaults.set(true, forKey: KeychainItem.isFirstRunning.rawValue)
                strongSelf.isSignUpSuccess.onCompleted()
                }, onError: { error in
                    print(error)
                    
            }, onCompleted: {
                print("Completion")
            }).disposed(by: disposeBag)
    }
    
    func signUpTapped() {
        self.btnSignUpTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let pass = strongSelf.password.value, let email = strongSelf.email.value else {
                print("error")
                return
            }
            
            if self?.isValidInput.value == true {
                if email.isValidEmail() && pass.isValidPassword() && self?.isChecked.value == true {
                    strongSelf.callAPISignUp()
                } else {
                    if email.isValidEmail() == false {
                        PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorInvalidEmail)
                        return
                    }
                    if pass.isValidPassword() == false {
                        PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorContentPassword)
                        return
                    }
                    if self?.isChecked.value == false {
                        PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorUncheckedCondition )
                        return
                    }
                }
            } else {
                if email.isValidEmpty() && pass.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorEmptyInputValue)
                    return
                }
                if email.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorEmptyEmail)
                    return
                }
                if pass.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorEmptyPassword)
                    return
                }
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
        if Connectivity.isConnectedToInternet {
            Provider.shared.authenticationService.signUp(email: email, password: pass)
                .subscribe(onNext: { [weak self] (user) in
                    guard let strongSelf = self else { return }
                    PopUpHelper.shared.showPopUp(message: ContantMessages.Login.successSignUp, action: {
                        strongSelf.userSignUp.value = user
                    })
                }, onError: { (error) in
                    print(error)
                }).disposed(by: disposeBag)
        } else {
            PopUpHelper.shared.showMessage(message: ContantMessages.Connection.errorConnection)
        }
    }
}
