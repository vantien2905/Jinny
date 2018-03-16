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
    
    public var email: Variable<String?>
    //public var isValidInput         : Variable<Bool>
    public var btnSubmitTapped: PublishSubject<Void>
//    var apiForgotPassword           : APIAuthenticationService?
    var popupView: PopUpView = PopUpView()
    
    init() {
//        apiForgotPassword = APIAuthenticationService()
        
        self.email = Variable<String?>(nil)
        self.btnSubmitTapped = PublishSubject<Void>()
        
        
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
        Provider.shared.authenticationService.forgotPassword(email: email)
        .subscribe(onNext: { [weak self] (user) in
            guard let strongSelf = self else { return }
            strongSelf.popupView.showPopUp(message: ContantMessages.Login.successResetPassword)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }

}
