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
        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] ( membership) in
            guard let strongSelf = self else { return }
            strongSelf.membership.value = membership
            strongSelf.isAddSuccess.value = true
            }, onError: { (_) in
                print("error")
                PopUpHelper.shared.showPopUp(message: "Code has already been taken", action: {
//                    self.isAddFail.value = true
                    print("askdjfg")
                })
        }).disposed(by: disposeBag)
    }
}
