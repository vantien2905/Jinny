//
//  MerchantDetailViewModel.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MerchantDetailViewModelProtocol {
    var idMerchant: Variable<Int> { get }
    var merchantDetail: Variable<[MerchantDetail]> { get }
}

class MerchantDetailViewModel: MerchantDetailViewModelProtocol {
    var merchantDetail: Variable<[MerchantDetail]> = Variable<[MerchantDetail]>([])
    var idMerchant: Variable<Int> = Variable<Int>(0)
    
    let disposeBag = DisposeBag()
    
    init(idMer: Int) {
        self.idMerchant.value = idMer
        idMerchant.asObservable().subscribe(onNext: {[weak self] (id) in
            self?.getMerchantDetail(id: id)
        }).disposed(by: disposeBag)
    }
    
    func getMerchantDetail(id: Int) {
        Provider.shared.merchantService.getMerchantDetail(idMerchant: id).subscribe(onNext: {[weak self] (merchant) in
            self?.merchantDetail.value = merchant
        }).disposed(by: disposeBag)
    }
}
