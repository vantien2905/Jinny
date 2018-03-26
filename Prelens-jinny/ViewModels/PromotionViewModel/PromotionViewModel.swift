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
    var isBookmark: Variable<Bool> = Variable<Bool> (false)
    
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
    
    func addBookmarkVoucher(idBookmark: Int) {
        Provider.shared.promotionService.addBookmarkVoucher(idBookmark: idBookmark).subscribe(onNext: { (promotion) in
            guard let _promotion = promotion else { return }
            self.isBookmark.value = _promotion.isBookMarked
        }).disposed(by: disposeBag)
    }
    
    
}
