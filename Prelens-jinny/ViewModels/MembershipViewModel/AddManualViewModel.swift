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
}

class AddManualViewModel: AddManualViewModelProtocol {
    var merchant: Variable<Merchant?> = Variable<Merchant?> (nil)
    let disposeBag = DisposeBag()
    var isAddSuccess: Variable<Bool> = Variable<Bool>(false)
    func addMembership(code: String, merchantId: Int) {
        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] (_) in
            self?.isAddSuccess.value = true
        }).disposed(by: disposeBag)
    }
}
