//
//  AchivedPromotionViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/30/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ArchivedPromotionViewModelProtocol {
    var textSearch: Variable<String?> {get set}
    var listAchivedPromotion: Variable<[Promotion]?> {get}
    var listSearchVoucher:  Variable<[Promotion]?> {get}
    var isLatest: Variable<Bool>{get set}
    func getListAchivedPromotion(order:String)
    func refresh()
    
}

class ArchivedPromotionViewModel: ArchivedPromotionViewModelProtocol{
    var isLatest: Variable<Bool>
    var textSearch: Variable<String?> = Variable<String?>(nil)
    var listSearchVoucher: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listAchivedPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
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
            
            self?.listAchivedPromotion.value = self?.listTemp
        }).disposed(by: disposeBag)
        sortAchivedPromotion()
    }
    
    func getListAchivedPromotion(order:String) {
        Provider.shared.promotionService.getListAchivedPromotion(order: order)
            .subscribe(onNext: { [weak self] (listPromotion) in
                guard let strongSelf = self else { return }
                strongSelf.listAchivedPromotion.value = listPromotion
                strongSelf.listSearchVoucher.value = listPromotion
            }).disposed(by: disposeBag)
    }
    
    func sortAchivedPromotion() {
        isLatest.asObservable().subscribe(onNext: {[weak self] (isLatest) in
            guard let strongSelf = self else { return }
            if isLatest {
                strongSelf.getListAchivedPromotion(order: "desc")
            } else {
               strongSelf.getListAchivedPromotion(order: "asc")
            }
        }).disposed(by: disposeBag)
    }
    func refresh() {
        isLatest.value = true
        getListAchivedPromotion(order: "desc")
    }
}
