//
//  AddMerchantViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AddMerchantViewModelProtocol {
    var listMerchant: Variable<[Merchant]> { get }
    var idMerchant: Variable<Int> { get }
    func loadData()
    var searchTextChange: Variable<String?> { get }
}

class AddMerchantViewModel: AddMerchantViewModelProtocol {
    var searchTextChange: Variable<String?> = Variable<String?>(nil)
    let disposeBag = DisposeBag()
    var listMerchant: Variable<[Merchant]> = Variable<[Merchant]>([])
    var idMerchant: Variable<Int> = Variable<Int>(0)
    
    var listRoot = [Merchant]()
    
    init() {
        searchTextChange.asObservable().subscribe(onNext: {(textSearch) in
                self.listMerchant.value = self.listRoot.filter({ (merchant) -> Bool in
                    guard let _name = merchant.name else { return false }
                    guard let _text = textSearch else { return true }
                    if _text == "" {
                        return true
                    } else {
                        return _name.containsIgnoringCase(_text)
                    }
                })
            
        }).disposed(by: disposeBag)
    }
    
    func loadData() {
        Provider.shared.memberShipService.getAllMerchants(page: 1, perPage: 1).asObservable().subscribe(onNext: {[weak self](listMerchant) in
            self?.listMerchant.value = listMerchant
            self?.listRoot = listMerchant
        }).disposed(by: disposeBag)
    }
}
