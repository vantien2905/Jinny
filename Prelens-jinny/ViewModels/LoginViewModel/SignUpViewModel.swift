//
//  SignUpViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 14/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

class SignUpViewModel {
    private var disposeBag = DisposeBag()
    
    public var email                : Variable<String?>
    public var password             : Variable<String?>
    public var isValidInput         : Variable<Bool>
    private var userSignUp          = Variable<PRUser?>(nil)
    public var btnSignUpTapped      : PublishSubject<Void>
    public var isLoginSuccess       : PublishSubject<Bool>
    var popupView                   :PopUpView = PopUpView()
    var isValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()){ email,password in email!.count > 0 && password!.count > 0
        }
    }
    
    var apiSignUp                   : APIAuthenticationService?
    
    init() {
        
        apiSignUp = APIAuthenticationService()
        
        self.email = Variable<String?>(nil)
        self.password = Variable<String?>(nil)
        self.isValidInput = Variable<Bool>(false)
        self.btnSignUpTapped = PublishSubject<Void>()
        self.isLoginSuccess = PublishSubject<Bool>()
        let isValid = self.checkValid(emailText: email.asObservable(), passwordText: password.asObservable())
        
        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)
        
        self.btnSignUpTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let pass = strongSelf.password.value else {
               return
            }
            if pass.isValidPassword() {
                strongSelf.callAPISignUp()
            } else {
                //                PopUpHelper.shared.showError(title: ConstantMessage.Login.errorTitlePassword, message: ConstantMessage.Login.errorContentPassword)
            }
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
    
    func callAPISignUp() {
        _ = apiSignUp?.signUp(email: self.email.value!, password:self.password.value!).asObservable().subscribe({ user in
            if user.element?.isSuccess == true {
                self.userSignUp.value = user.element?.data
                print("Sign up success!")
            } else {
                print(user.element?.message ?? "")
            }
        })
    }
}
