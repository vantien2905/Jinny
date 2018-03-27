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

protocol PromotionViewModelProtocol {
    var listAllPromotion: Variable<[Promotion]?> {get}
    var listStarredPromotion: Variable<[Promotion]?>{get}
}

class PromotionViewModel: PromotionViewModelProtocol {
    var listAllPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listStarredPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    let disposeBag = DisposeBag()

//    class PromotionViewModelInput {
//    }
//    class PromotionViewModelOutput {
//        var listAllPromotion        = Variable<[Promotion]>([])
//        var listStarredPromotion    = Variable<[Promotion]>([])
//    }
//
//    var inputs = PromotionViewModelInput()
//    var outputs = PromotionViewModelOutput()
//    
    init() {
        getListAllPromotion()
        getListStarredPromotion()
    }

    func getListAllPromotion() {
        Provider.shared.promotionService.getListAllPromotion().subscribe(onNext: { (listPromotion) in
            self.listAllPromotion.value = listPromotion
        }).disposed(by: disposeBag)
    }
    
    func getListStarredPromotion() {
        Provider.shared.promotionService.getListStarredPromotion().subscribe(onNext: { (listPromotion) in
            self.listStarredPromotion.value = listPromotion
        }).disposed(by: disposeBag)
    }
    
}
