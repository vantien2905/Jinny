//
//  ScanCodeViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ScanCodeViewModelProtocol {
    var merchant: Variable<Merchant?> { get }
    var isAddSuccess: Variable<Bool> { get }
    func addMembership(code: String, merchantId: Int)
    var isAddFail: Variable<Bool> { get }
    var membership: Variable<Member?> { get }
}

class ScanCodeViewModel: ScanCodeViewModelProtocol {
    var membership: Variable<Member?> = Variable<Member?> (nil)
    
    var isAddFail: Variable<Bool> = Variable<Bool>( false )
    
    var merchant: Variable<Merchant?> = Variable<Merchant?>(nil)
    var isAddSuccess: Variable<Bool> = Variable<Bool>(false)
    let disposeBag = DisposeBag()
    func addMembership(code: String, merchantId: Int) {
        
        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] ( membership) in
            guard let strongSelf = self else { return }
            strongSelf.membership.value = membership
            strongSelf.isAddSuccess.value = true
            }, onError: { (_) in
                print("error")
                PopUpHelper.shared.showPopUp(message: "Code has already been taken", action: {
                    self.isAddFail.value = true
                })
        }).disposed(by: disposeBag)
    }
}
