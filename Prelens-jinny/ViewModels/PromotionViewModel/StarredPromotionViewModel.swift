//
//  StarredPromotionViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/28/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol StarredPromotionViewModelProtocol {
    var textSearch: Variable<String?> {get set}
    var listSearchVoucher:  Variable<[Promotion]?> {get}
    var listStarredPromotion: Variable<[Promotion]?> {get}
    var isLatest: Variable<Bool> {get}
    func getListStarredPromotion(order:String)
    func refresh()
}

class StarredPromotionViewModel: StarredPromotionViewModelProtocol {
    var isLatest: Variable<Bool>
    var textSearch: Variable<String?> = Variable<String?>(nil)
    var listSearchVoucher: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listStarredPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listTemp = [Promotion]()
    let disposeBag = DisposeBag()
    init() {
        isLatest = Variable<Bool>(true)
        textSearch.asObservable().subscribe(onNext: {[weak self] (textSearch) in
            let listVoucher = self?.listSearchVoucher.value?.filter { (promotion) -> Bool in
                guard let _textSearch = textSearch else { return true }
                if _textSearch == "" {
                    return true
                } else {
                    if let _merchant = promotion.merchant, let _name = _merchant.name {
                        return _name.containsIgnoringCase(_textSearch)
                    }
                    return false
                }
            }
            if let _list = listVoucher {
                self?.listTemp = _list
            }
            
            self?.listStarredPromotion.value = self?.listTemp
        }).disposed(by: disposeBag)
        sortStarredPromotion()
    }
    
    func sortStarredPromotion() {
        isLatest.asObservable().subscribe(onNext: {[weak self] (isLatest) in
            guard let strongSelf = self else { return }
            if isLatest {
               strongSelf.getListStarredPromotion(order: "desc")
            } else {
               strongSelf.getListStarredPromotion(order: "asc")
            }
        }).disposed(by: disposeBag)
    }
    
    func getListStarredPromotion(order:String) {
        Provider.shared.promotionService.getListStarredPromotion(order:order).subscribe(onNext: { (listPromotion) in
            self.listStarredPromotion.value = listPromotion
            self.listSearchVoucher.value = listPromotion
        }).disposed(by: disposeBag)
    }
    func refresh() {
        isLatest.value = true
        getListStarredPromotion(order: "desc")
    }
}
