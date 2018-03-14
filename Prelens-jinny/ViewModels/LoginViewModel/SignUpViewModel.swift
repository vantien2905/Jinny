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
    
    public var email                : Variable<String?>
    public var password             : Variable<String?>
    public var isValidInput         : Variable<Bool>
    private var userSignUp          = Variable<PRUser?>(nil)
    public var btnSignUpTapped      : PublishSubject<Void>
    public var isChecked            : Variable<Bool>
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
        self.isChecked = Variable<Bool>(false)
        self.btnSignUpTapped = PublishSubject<Void>()
        self.isLoginSuccess = PublishSubject<Bool>()
        
        _ = isChecked.asObservable().subscribe(onNext: { [weak self] value in
            print(value)
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
                    self?.popupView.showPopUp(message: "Please enter your email & password")
                } else if self?.isChecked.value == false {
                    self?.popupView.showPopUp(message: "Please indicate that you have agree to the Terms and Conditions")
                } else {
                    strongSelf.callAPISignUp()
                }
            }
            else {
                self?.popupView.showPopUp(message: ContantMessages.Login.errorContentPassword)
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
                self.popupView.showPopUp(message: "Sign up success!")
                self.resetUI()
            } else {
                self.popupView.showPopUp(message: user.element?.message ?? "")
            }
        })
    }
    
    func resetUI() {
        self.email.value = ""
        self.password.value = ""
    }
}
