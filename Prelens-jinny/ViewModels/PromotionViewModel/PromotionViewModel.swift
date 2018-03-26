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

class PromotionViewModel {
    let disposeBag = DisposeBag()
    
    class PromotionViewModelInput {
        
    }
    
    class PromotionViewModelOutput {
        var listAllPromotion        = Variable<[Promotion]>([])
        var listStarredPromotion    = Variable<[Promotion]>([])
    }
    
    var inputs = PromotionViewModelInput()
    var outputs = PromotionViewModelOutput()
    
    func getListAllPromotion() {
        Provider.shared.promotionService.getListAllPromotion().subscribe(onNext: { (listPromotion) in
            self.outputs.listAllPromotion.value = listPromotion
        }).disposed(by: disposeBag)
    }
    
    func getListStarredPromotion(){
        Provider.shared.promotionService.getListStarredPromotion().subscribe(onNext: { (listPromotion) in
            self.outputs.listStarredPromotion.value = listPromotion
        }).disposed(by: disposeBag)
    }
}
