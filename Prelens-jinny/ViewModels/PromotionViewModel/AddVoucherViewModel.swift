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
    func addVoucher(code: String)
}



class AddVoucherViewModel: AddVoucherViewModelProtocol {
    let disposeBag = DisposeBag()
    
    func addVoucher(code: String) {
        Provider.shared.promotionService.addVoucher(code: code).asObservable().subscribe(onNext: {[weak self] (voucher) in
            
        }).disposed(by: disposeBag)

    }
    
}
