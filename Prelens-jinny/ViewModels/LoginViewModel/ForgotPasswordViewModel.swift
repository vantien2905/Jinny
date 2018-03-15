//
//  ForgotPasswordViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

final class ForgotPasswordViewModel {
    
    private var disposeBag          = DisposeBag()
    
    public var email                : Variable<String?>
    //public var isValidInput         : Variable<Bool>
    public var btnSubmitTapped      : PublishSubject<Void>
    var apiForgotPassword           : APIAuthenticationService?
    var popupView                   :PopUpView = PopUpView()
    
    init() {
        apiForgotPassword = APIAuthenticationService()
        
        self.email = Variable<String?>(nil)
        self.btnSubmitTapped = PublishSubject<Void>()
        
        //let isValid = self.checkValid(emailText: email.asObservable())
        //isValid.asObservable().subscribe(onNext: { [unowned self] value in
        //   self.isValidInput.value = value
        //}).disposed(by: disposeBag)
        
        self.btnSubmitTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let email = strongSelf.email.value else { return }
            if email.isValidEmpty() == false {
                self?.callAPIForgotPassword()
            } else {
                self?.popupView.showPopUp(message: "Please enter your email")
            }
        }).disposed(by: disposeBag)
    }
    
    
    func callAPIForgotPassword() {
        guard let email = self.email.value else { return }
         _ = apiForgotPassword?.forgotPassword(email: email).asObservable().subscribe({ message in
            if message.element?.isSuccess ==  true {
                self.popupView.showPopUp(message: ContantMessages.Login.successResetPassword)
                self.email.value = ""
            } else {
                let errorMessage = message.element?.message ?? ""
                self.popupView.showPopUp(message: errorMessage)
            }
        })
    }
    
   
}
