//
//  ChangePasswordViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

internal protocol ChangePasswordViewModelInputs {

    var currentPassword: Variable<String?> {get}
    var newPassword: Variable<String?> {get}
    var btnChangeTapped: PublishSubject<Void> { get }
}
internal protocol ChangePasswordViewModelType {
    var inputs: ChangePasswordViewModelInputs { get }
}

final class ChangePasswordViewModel {

    private var disposeBag          = DisposeBag()

    public var currentPassword: Variable<String?>
    public var newPassword: Variable<String?>
    public var isValidInput: Variable<Bool>
    public var btnChangeTapped: PublishSubject<Void>

    init() {
        self.currentPassword        = Variable<String?>(nil)
        self.newPassword            = Variable<String?>(nil)
        self.btnChangeTapped        = PublishSubject<Void>()
        self.isValidInput           = Variable<Bool>(false)

        let isValid = self.checkValid(curPassword: currentPassword.asObservable(), newPassword: newPassword.asObservable())

        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)

        self.btnChangeTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let curPassword = strongSelf.currentPassword.value, let newPassword = strongSelf.newPassword.value else { return }
            if curPassword.isValidPassword() && newPassword.isValidPassword() {
                self?.callAPIChangePassword()
            } else {
                if curPassword.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message:"Current password can't be blank")
                    return
                }
                if newPassword.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message:"New password can't be blank")
                    return
                }
                PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorContentPassword)
            }
         }).disposed(by: disposeBag)
    }

    func checkValid(curPassword: Observable<String?>, newPassword: Observable<String?>) -> Observable<Bool> {
        return Observable.combineLatest(curPassword, newPassword) {(curPassword, newPassword) -> Bool in
            guard let _curPassword = curPassword, let _newPassword = newPassword else {
                return false
            }
            return  ( !_curPassword.isValidEmpty() && !_newPassword.isValidEmpty())
        }
    }

    func callAPIChangePassword() {
        guard let _currentPassword = self.currentPassword.value, let _newPassword = self.newPassword.value else { return }
        Provider.shared.authenticationService.changePassword(currentPassword: _currentPassword, newPassword: _newPassword)
            .subscribe(onNext: { [weak self] (_) in
                guard let strongSelf = self else { return }
                PopUpHelper.shared.showMessage(message: ContantMessages.User.successChangePassword)
                strongSelf.currentPassword.value = ""
                strongSelf.newPassword.value = ""
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
}
