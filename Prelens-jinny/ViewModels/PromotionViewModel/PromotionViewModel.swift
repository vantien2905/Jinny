//
//  PromotionViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

class PromotionViewModel {
    let disposeBag = DisposeBag()
    
    class PromotionViewModelInput {
        
    }
    
    class PromotionViewModelOutput {
        var listPromotion: Variable<Promotion?>  = Variable<Promotion?> (nil)
    }
    
    var inputs = PromotionViewModelInput()
    var outputs = PromotionViewModelInput()
    
    func getListPromotion() {
        
    }
}
