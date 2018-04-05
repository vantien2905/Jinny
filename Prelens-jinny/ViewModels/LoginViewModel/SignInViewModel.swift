//
//  SignInViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

final class SignInViewModel {

    private var disposeBag = DisposeBag()

    public var email: Variable<String?>
    public var password: Variable<String?>
    public var isValidInput: Variable<Bool>
    private var userLogin = Variable<PRUser?>(nil)
    public var btnSignInTapped: PublishSubject<Void>
    public var isLoginSuccess: PublishSubject<Bool>
    var isValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) { email, password in email!.count > 0 && password!.count > 0
        }
    }
    init() {
        self.email = Variable<String?>(nil)
        self.password = Variable<String?>(nil)
        self.isValidInput = Variable<Bool>(false)
        self.btnSignInTapped = PublishSubject<Void>()
        self.isLoginSuccess = PublishSubject<Bool>()
        let isValid = self.checkValid(emailText: email.asObservable(), passwordText: password.asObservable())

        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)
        
        self.btnSignInTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let pass = strongSelf.password.value, let email = strongSelf.email.value else {
                print("error")
                return
            }
            
            if self?.isValidInput.value == true {
                if email.isValidEmail() && pass.isValidPassword() {
                    strongSelf.callAPISignIn()
                } else {
                    if email.isValidEmail() == false {
                        PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorInvalidEmail)
                        return
                    }
                    if pass.isValidPassword() == false {
                        PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorContentPassword)
                        return
                    }
                }
            } else {
                if email.isValidEmpty() && pass.isValidEmpty(){
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

        userLogin.asObservable()
            .ignoreNil()
            .subscribe(onNext: {  [weak self] userLogin in
                guard let strongSelf = self else { return }
                let defaults = UserDefaults.standard
                if let token = userLogin.token {
                      KeychainManager.shared.saveString(value: strongSelf.email.value&, forkey: .email)
                      KeychainManager.shared.setToken(token)
                      KeychainManager.shared.saveString(value: "7", forkey: KeychainItem.leftDayToRemind)
                }
                strongSelf.isLoginSuccess.onCompleted()
                defaults.set(true, forKey: KeychainItem.isFirstRunning.rawValue)
                }, onError: { error in
                    print(error)

            }, onCompleted: {
                print("Completion")
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

    func callAPISignIn() {
        guard let _email = self.email.value, let _password = self.password.value else {return}
        Provider.shared.authenticationService.login(email: _email, password: _password).subscribe(onNext: { [weak self] (user) in
            self?.userLogin.value = user
        }).disposed(by: disposeBag)
    }
    
    
}
