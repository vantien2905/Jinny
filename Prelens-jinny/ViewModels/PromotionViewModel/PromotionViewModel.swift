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
        var listPromotion = Variable<[Promotion]>([])
    }
    
    var inputs = PromotionViewModelInput()
    var outputs = PromotionViewModelOutput()
    
    func getListPromotion() {
        Provider.shared.promotionService.getListAllPromotion().subscribe(onNext: { (listPromotion) in
            self.outputs.listPromotion.value = listPromotion
        }).disposed(by: disposeBag)
    }
}
