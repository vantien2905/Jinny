//
//  AddManualViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift

protocol AddManualViewModelProtocol {
    var merchant: Variable<Merchant?> { get }
    func addMembership(code: String, merchantId: Int)
    var isAddSuccess: Variable<Bool> { get }
    var membership: Variable<Member?> { get }
}

class AddManualViewModel: AddManualViewModelProtocol {
    var membership: Variable<Member?> = Variable<Member?>(nil)
    
    var merchant: Variable<Merchant?> = Variable<Merchant?> (nil)
    let disposeBag = DisposeBag()
    var isAddSuccess: Variable<Bool> = Variable<Bool>(false)
    func addMembership(code: String, merchantId: Int) {
        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] (membership) in
            self?.membership.value = membership
            self?.isAddSuccess.value = true
        }).disposed(by: disposeBag)
    }
}
