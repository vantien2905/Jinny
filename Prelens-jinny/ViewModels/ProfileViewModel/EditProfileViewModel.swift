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
    public var regionID: Variable<Int?>
    public var gender : Variable<String?>
    public var isUpdateSuccess: PublishSubject<Bool>
    var user = Variable<PRUser?>(nil)
    var regions = Variable<[ResidentialRegion]>([])
    
    init() {
        self.email = Variable<String?>("")
        self.name  = Variable<String?>("")
        self.dob  = Variable<String?>("")
        self.btnSaveTapped = PublishSubject<Void>()
        self.isValidInput = Variable<Bool>(false)
        self.regionID = Variable<Int?>(nil)
        self.gender  = Variable<String?>(nil)
        self.isUpdateSuccess = PublishSubject<Bool>()
        let isValid = self.checkValid(emailText: email.asObservable(), nameText: name.asObservable(), dobText: dob.asObservable())
        isValid.asObservable().subscribe(onNext: { [unowned self] value in
            self.isValidInput.value = value
        }).disposed(by: disposeBag)
        
        self.btnSaveTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            guard let _email = strongSelf.email.value, let _name = strongSelf.name.value, let _dob = strongSelf.dob.value else {
                print("error")
                return
            }
            if strongSelf.isValidInput.value == true {
                 strongSelf.updateProfile()
            } else {
                if _name.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: "Name can't be blank")
                    return
                }
                if _email.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: "Email can't be blank")
                    return
                }
                if _dob.isValidEmpty() {
                    PopUpHelper.shared.showMessage(message: "Date of birth can't be blank")
                    return
                }
                if _email.isValidEmail() == false {
                    PopUpHelper.shared.showMessage(message: "Email is invalid")
                    return
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func getProfile() {
        if Connectivity.isConnectedToInternet {
            Provider.shared.profileService.getProfile().subscribe(onNext: { [weak self] (user) in
                self?.user.value = user
            }).disposed(by: disposeBag)
        } else {
             PopUpHelper.shared.showMessage(message: ContantMessages.Connection.errorConnection)
        }
    }
    
    func getResidentialRegion() {
            Provider.shared.profileService.getResidentialRegion().subscribe(onNext: { [weak self] (list) in
                self?.regions.value = list
            }).disposed(by: disposeBag)
    }
    
    func updateProfile() {
        guard let email = self.email.value, let name = self.name.value, let dob = self.dob.value else { return }
        if Connectivity.isConnectedToInternet {
            Provider.shared.profileService.updateProfile(fullName: name, email: email, dateOfBirth: dob, regionID: self.regionID.value, gender: self.gender.value)
                .subscribe(onNext: { [weak self] (user) in
                    guard let strongSelf = self else { return }
                    strongSelf.user.value = user
                    KeychainManager.shared.saveString(value: email, forkey: .email)
                    KeychainManager.shared.saveString(value: name, forkey: .displayName)
                    PopUpHelper.shared.showPopUp(message: "Update profile success", action: {
                        strongSelf.isUpdateSuccess.onCompleted()
                    })
                }, onError: { (error) in
                        print(error)
                }).disposed(by: disposeBag)
        } else {
            PopUpHelper.shared.showMessage(message: ContantMessages.Connection.errorConnection)
        }
    }
    
    func checkValid(emailText: Observable<String?>, nameText: Observable<String?>, dobText: Observable<String?>) -> Observable<Bool> {
        return Observable.combineLatest(emailText, nameText, dobText) {(email, name, dob) -> Bool in
            guard let _email = email, let _name = name, let _dob = dob else {
                return false
            }
            return  ( _email.isValidEmail() && !_name.isValidEmpty() && !_dob.isValidEmpty())
        }
    }
}
