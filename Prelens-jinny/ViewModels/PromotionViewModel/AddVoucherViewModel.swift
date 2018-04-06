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
            }, onError: { (_) in
                if errorNotExit.value == true {
                    self.resultString.value = "The resource you are looking for doesn't exist"
                }
                if errorQROut.value == true {
                    self.resultString.value = "Out Of Stock"
                }
                if errordidAcquired.value == true {
                    self.resultString.value = "You're already acquire this voucher"
                }
        }).disposed(by: disposeBag)
    }
}
