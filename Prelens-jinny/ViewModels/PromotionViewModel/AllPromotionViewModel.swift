//
//  PromotionViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

protocol AllPromotionViewModelProtocol {
    var textSearch: Variable<String?> {get set}
    var listAllPromotion: Variable<[Promotion]?> {get}
    var listSearchVoucher:  Variable<[Promotion]?> {get}
    var isLatest: Variable<Bool>{get set}
    func getListAllPromotion(order: String)
    func refresh()
}

class AllPromotionViewModel: AllPromotionViewModelProtocol {
    var isLatest: Variable<Bool>
    var textSearch: Variable<String?> = Variable<String?>(nil)
    var listSearchVoucher: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listAllPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
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
            
            self?.listAllPromotion.value = self?.listTemp
        }).disposed(by: disposeBag)
        sortAllPromotion()
    }
    
    func getListAllPromotion(order:String) {
        Provider.shared.promotionService.getListAllPromotion(order: order)
            //.showProgressIndicator()
            .subscribe(onNext: { [weak self] (listPromotion) in
                guard let strongSelf = self else { return }
                strongSelf.listAllPromotion.value = listPromotion
                strongSelf.listSearchVoucher.value = listPromotion
            }).disposed(by: disposeBag)
    }
    
    func sortAllPromotion() {
        isLatest.asObservable().subscribe(onNext: {[weak self] (isLatest) in
            guard let strongSelf = self else { return }
            if isLatest {
                strongSelf.getListAllPromotion(order: "desc")
           } else {
                 strongSelf.getListAllPromotion(order: "asc")
            }
        }).disposed(by: disposeBag)
    }
    func refresh() {
        if isLatest.value {
            getListAllPromotion(order: "desc")
        } else {
            getListAllPromotion(order: "asc")
        }
    }
}
