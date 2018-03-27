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
    public var btnSubmitTapped: PublishSubject<Void>
     public var isSuccess: PublishSubject<Bool>
    
    init() {
        self.email = Variable<String?>(nil)
        self.btnSubmitTapped = PublishSubject<Void>()
         self.isSuccess = PublishSubject<Bool>()
        
        self.btnSubmitTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let email = strongSelf.email.value else { return }
            if email.isValidEmpty() == false {
                if email.isValidEmail() {
                    self?.callAPIForgotPassword()
                } else {
                    PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorInvalidEmail)
                }
            } else {
                PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorEmptyEmail)
            }
        }).disposed(by: disposeBag)
    }

    func callAPIForgotPassword() {
        guard let email = self.email.value else { return }
        Provider.shared.authenticationService.forgotPassword(email: email)
        .subscribe(onNext: { [weak self] (_) in
            guard let strongSelf = self else { return }
            PopUpHelper.shared.showPopUp(message: ContantMessages.Login.successResetPassword, action: {
                strongSelf.isSuccess.onCompleted()
            })
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }
}
