//
//  PromotionDetailViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 20/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PromotionDetailViewModelProtocol {
    var idVoucher: Variable<Int> { get }
    var voucherDetail: Variable<PromotionDetail?> { get }
}

class PromotionDetailViewModel: PromotionDetailViewModelProtocol {
    var idVoucher: Variable<Int> = Variable<Int>(0)
    var voucherDetail: Variable<PromotionDetail?> = Variable<PromotionDetail?>(nil)

    let disposeBag = DisposeBag()
    
    init(id: Int) {
        self.idVoucher.value = id
        idVoucher.asObservable().subscribe(onNext: {[weak self] (id) in
            self?.getVoucherDetail(id: id)
        }).disposed(by: disposeBag)
    }
    
    func getVoucherDetail(id : Int) {
        Provider.shared.promotionService.getPromotionDetail(id: id).subscribe(onNext: {[weak self] (voucher) in
            self?.voucherDetail.value = voucher
        }).disposed(by: disposeBag)
    }
}
