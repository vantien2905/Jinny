//
//  ForgotPasswordViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/14/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ForgotPasswordViewModelProtocol {
    var email: Variable<String?> {get set}
    var btnSubmitTapped:PublishSubject<Void>{get}
    var isSuccess: PublishSubject<Bool>{get}
    func callAPIForgotPassword()
}

final class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    private var disposeBag          = DisposeBag()
    var email: Variable<String?>
    var btnSubmitTapped: PublishSubject<Void>
    var isSuccess: PublishSubject<Bool>
    
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
        if Connectivity.isConnectedToInternet {
            Provider.shared.authenticationService.forgotPassword(email: email)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else { return }
                PopUpHelper.shared.showPopUp(message: ContantMessages.Login.successResetPassword, action: {
                    strongSelf.isSuccess.onCompleted()
                })
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
        } else {
            PopUpHelper.shared.showMessage(message: ContantMessages.Connection.errorConnection)
        }
    }
}
