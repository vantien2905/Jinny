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
    public var isLoginSuccess:PublishSubject<Bool>
     var popupView: PopUpView = PopUpView()
    var isValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()){ email,password in email!.count > 0 && password!.count > 0
        }
    }
    
//    var apiSignIn                   : APIAuthenticationService = APIAuthenticationService()
    
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
            guard let pass = strongSelf.password.value else {
               
//                PopUpHelper.shared.showError(title: ConstantMessage.Login.errorTitlePassword, message: ConstantMessage.Login.errorContentPassword)
                return
            }
            if pass.isValidPassword() {
                strongSelf.callAPISignIn()
            } else {
                self?.popupView.showPopUp(message: ContantMessages.Login.errorContentPassword)
            }
        }).disposed(by: disposeBag)
        
        userLogin.asObservable()
            .ignoreNil()
            .subscribe(onNext: {  [weak self] _userLogin in
                guard let strongSelf = self else { return }
                
                if let token = _userLogin.token {
                      KeychainManager.shared.saveString(value: strongSelf.password.value&, forkey: .password)
                      KeychainManager.shared.saveString(value: strongSelf.email.value&, forkey: .email)
                      KeychainManager.shared.setToken(token)
                }
                
                strongSelf.isLoginSuccess.onCompleted()
                }, onError: { error in
                    print(error)

            }, onCompleted: {
                print("Completion")
            }).disposed(by: disposeBag)
        
    }
    
    func checkValid(emailText: Observable<String?>, passwordText: Observable<String?>) -> Observable<Bool> {
        return Observable.combineLatest(emailText, passwordText) {(email,password) -> Bool in
            guard let _email = email, let _password = password else {
                return false
            }
            return  ( !_email.isValidEmpty() && !_password.isValidEmpty())
        }
    }
    
    func callAPISignIn() {
//       _ = apiSignIn.signIn(email: self.email.value!, password:self.password.value!).asObservable().subscribe({ user in
//            if user.element?.isSuccess == true {
//                print("Sign in success!")
//                self.userLogin.value = user.element?.data
//            } else {
//                self.popupView.showPopUp(message: user.element?.message ?? "")
//            }
//        })
    }
}
