
//
//  SignOutViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 4/6/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

final class SignOutViewModel {
    
    private var disposeBag = DisposeBag()
    public var btnSignOutTapped: PublishSubject<Void>
    
    init(){
        self.btnSignOutTapped = PublishSubject<Void>()
        self.btnSignOutTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            strongSelf.callAPISignOut()
        }).disposed(by: disposeBag)
    }
    
    func callAPISignOut() {
        Provider.shared.authenticationService.signOut().subscribe(onNext: {(response) in
            if response == nil {
                KeychainManager.shared.deleteAllSavedData()
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                appDelegate.goToLogin()
            } else {
                PopUpHelper.shared.showMessage(message: (response?.message ?? ""))
            }
        })
        .disposed(by: disposeBag)
    }
}
