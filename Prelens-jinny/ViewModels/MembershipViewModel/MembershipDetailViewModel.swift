//
//  MembershipDetailViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift

class MembershipDetailViewModel {
    
    let disposeBag = DisposeBag()
    class MembershipDetailViewModelInput {
        var idMembership: Variable<Int> = Variable<Int>(0)
    }
    
    class MembershipDetailViewModelOutput {
        var membership: Variable<Member?> = Variable<Member?>(nil)
    }
    
    var inputs = MembershipDetailViewModelInput()
    var outputs = MembershipDetailViewModelOutput()
    var apiService = APIMembershipService()
    
    init() {
        inputs.idMembership.asObservable().subscribe(onNext: { id in
            self.apiService.getMembershipDetail(id: id).asObservable().subscribe(onNext: { (detail) in
                self.outputs.membership.value = detail.data
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
    }

}
