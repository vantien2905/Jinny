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
    public var btnSubmitTapped      : PublishSubject<Void>
    
    init() {
        self.email = Variable<String?>(nil)
        self.btnSubmitTapped = PublishSubject<Void>()
        
        self.btnSubmitTapped.subscribe(onNext: { [weak self]  in
            guard let strongSelf = self else { return }
            //TODO
        }).disposed(by: disposeBag)
    }
    
    func callAPIForgotPassword() {
            //TODO
    }
}
