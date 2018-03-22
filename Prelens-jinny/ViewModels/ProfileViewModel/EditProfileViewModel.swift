//
//  EditProfileViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileViewModel {
    
    let disposeBag = DisposeBag()
    public var email: Variable<String?>
    public var name : Variable<String?>
    public var dob  : Variable<String?>
    public var btnSaveTapped: PublishSubject<Void>
    public var isValidInput: Variable<Bool>
    
    var user = Variable<PRUser?>(nil)
    
    init() {
        self.email = Variable<String?>(nil)
        self.name  = Variable<String?>(nil)
        self.dob  = Variable<String?>(nil)
        self.btnSaveTapped = PublishSubject<Void>()
        self.isValidInput = Variable<Bool>(false)
        
        let isValid = self.checkValid(emailText: email.asObservable(), nameText: name.asObservable(), dobText: dob.asObservable())
        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)
        
        self.btnSaveTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let _email = strongSelf.email.value, let _name = strongSelf.name.value , let _dob = strongSelf.dob.value else {return}
            
            if strongSelf.isValidInput.value == true {
                 strongSelf.updateProfile()
            } else {
                if _email.isValidEmpty() == false {
                    PopUpHelper.shared.showMessage(message: "Validation failed: Email can't be blank")
                    return
                }
                if _name.isValidEmpty() == false {
                    PopUpHelper.shared.showMessage(message: "Validation failed: Name can't be blank")
                    return
                }
                if _dob.isValidEmpty() == false {
                    PopUpHelper.shared.showMessage(message: "Validation failed: Date of birth can't be select")
                    return
                }
            }
//            else {
//                if email.isValidEmail() == false {
//                    PopUpHelper.shared.showMessage(message: ContantMessages.Login.errorInvalidEmail)
//                    return
//                }
//                if name.isValidEmpty() == true {
//                    PopUpHelper.shared.showMessage(message: "Name can't be blank")
//                    return
//                }
//                if dob.isValidEmpty() == true {
//                    PopUpHelper.shared.showMessage(message: "Please select doate of birth")
//                    return
//                }
//            }
        }).disposed(by: disposeBag)
    }
    
    func getProfile() {
        Provider.shared.profileService.getProfile().subscribe(onNext: { [weak self] (user) in
            self?.user.value = user
        }).disposed(by: disposeBag)
    }
    
    func updateProfile() {
        guard let email = self.email.value, let name = self.name.value, let dob = self.dob.value else { return }
        Provider.shared.profileService.updateProfile(fullName: name, email: email, dateOfBirth: dob)
            .subscribe(onNext: { [weak self] (user) in
                guard let strongSelf = self else { return }
                strongSelf.user.value = user
                PopUpHelper.shared.showMessage(message: "Update profile success")
                }, onError: { (error) in
                    print(error)
            }).disposed(by: disposeBag)
    }
    
    func checkValid(emailText: Observable<String?>, nameText: Observable<String?>, dobText: Observable<String?>) -> Observable<Bool> {
        return Observable.combineLatest(emailText, nameText, dobText) {(email, name, dob) -> Bool in
            guard let _email = email, let _name = name, let _dob = dob else {
                return false
            }
            return  ( !_email.isValidEmpty() && !_name.isValidEmpty() && !_dob.isValidEmpty())
        }
    }
}
