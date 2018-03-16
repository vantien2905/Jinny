//
//  MembershipViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa


class MembershipViewModel {
    let disposeBag = DisposeBag()
    
    class MembershipViewModelInput {
        
    }
    
    class MembershipViewModelOutput {
        var listMembership: Variable<Membership?>  = Variable<Membership?> (nil)
    }
    
    var inputs = MembershipViewModelInput()
    var outputs = MembershipViewModelOutput()
//    var apiService = APIMembershipService()
    
    
    init() {
//        apiService.getListAllMembership().asObservable().subscribe(onNext: { (member) in
//            self.outputs.listMembership.value = member.data
//
//        }).disposed(by: disposeBag)
    }
}
