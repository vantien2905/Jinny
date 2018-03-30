//
//  AddVoucherViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 29/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AddVoucherViewModelProtocol {
    var resultString: Variable<String?> { get set }
    func addVoucher(code: String)
}

class AddVoucherViewModel: AddVoucherViewModelProtocol {
    var resultString: Variable<String?> = Variable<String?>(nil)
    
    let disposeBag = DisposeBag()
    
    func addVoucher(code: String) {
        Provider.shared.promotionService.addVoucher(code: code).asObservable().subscribe(onNext: {[weak self] (_) in
            self?.resultString.value = "Voucher Added!"
            
            }, onError: { (error) in
                
        }).disposed(by: disposeBag)
    }
}
