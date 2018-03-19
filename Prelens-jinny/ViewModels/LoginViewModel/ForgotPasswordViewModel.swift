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

    init() {
        self.email = Variable<String?>(nil)
        self.btnSubmitTapped = PublishSubject<Void>()

        self.btnSubmitTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let email = strongSelf.email.value else { return }
            if email.isValidEmpty() == false {
                self?.callAPIForgotPassword()
            } else {
                PopUpHelper.shared.showMessage(message: "Please enter your email")
            }
        }).disposed(by: disposeBag)
    }

    func callAPIForgotPassword() {
        guard let email = self.email.value else { return }
        Provider.shared.authenticationService.forgotPassword(email: email)
        .subscribe(onNext: { [weak self] (_) in
            guard let strongSelf = self else { return }
            PopUpHelper.shared.showMessage(message: ContantMessages.Login.successResetPassword)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }

}
