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
    func getListAllPromotion()
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
//        getListAllPromotion()
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
    
    func getListAllPromotion() {
        Provider.shared.promotionService.getListAllPromotion()
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
            let other = strongSelf.listAllPromotion.value
            if isLatest {
                if let _other = other {
                    strongSelf.listAllPromotion.value = _other.sorted(by: { (other1, other2) -> Bool in
                        return other1 > other2
                    })
                }
            } else {
                if let _other = other {
                    strongSelf.listAllPromotion.value = _other.sorted(by: { (other1, other2) -> Bool in
                        return other1 < other2
                    })
                }
                
            }
            strongSelf.listAllPromotion.value = strongSelf.listAllPromotion.value
        }).disposed(by: disposeBag)
    }
    func refresh() {
        //getListAllPromotion()
    }
}
