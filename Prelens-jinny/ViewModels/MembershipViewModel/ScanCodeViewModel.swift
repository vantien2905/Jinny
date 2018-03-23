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
}

class ScanCodeViewModel: ScanCodeViewModelProtocol {
    var isAddFail: Variable<Bool> = Variable<Bool>( false )
    
    var merchant: Variable<Merchant?> = Variable<Merchant?>(nil)
    var isAddSuccess: Variable<Bool> = Variable<Bool>(false)
    let disposeBag = DisposeBag()
    func addMembership(code: String, merchantId: Int) {
//        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] (_) in
//            self?.isAddSuccess.value = true
//        }).disposed(by: disposeBag)
        
        Provider.shared.memberShipService.addMembership(code: code, merchantId: merchantId).subscribe(onNext: {[weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.isAddSuccess.value = true
            }, onError: { (_) in
                print("error")
                self.isAddFail.value = true
        }).disposed(by: disposeBag)
    }
}
