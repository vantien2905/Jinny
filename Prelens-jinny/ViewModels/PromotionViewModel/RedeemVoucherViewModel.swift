//
//  RedeemVoucherViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 4/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RedeemVoucherViewModelProtocol {
    var resultString: Variable<String?> { get set }
    func redeemVoucher(idVoucher: String)
}

class RedeemVoucherViewModel: RedeemVoucherViewModelProtocol {
    var resultString: Variable<String?> = Variable<String?>(nil)
    let disposeBag = DisposeBag()
    
    func redeemVoucher(idVoucher: String) {
        Provider.shared.promotionService.redeemVoucher(idVoucher: idVoucher).subscribe(onNext: {[weak self] (_) in
            self?.resultString.value = "Voucher redeemed"
        }).disposed(by: disposeBag)
    }
}
