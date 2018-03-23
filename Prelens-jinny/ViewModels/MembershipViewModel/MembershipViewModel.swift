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
        var textSearch: Variable<String?> = Variable<String?>(nil)
        var listTemp = Membership()
    }

    class MembershipViewModelOutput {
        var listMembership: Variable<Membership?>  = Variable<Membership?> (nil)
        var listSearchMember: Variable<Membership?>  = Variable<Membership?> (nil)
    }

    var inputs = MembershipViewModelInput()
    var outputs = MembershipViewModelOutput()

    func getListMembership() {
        Provider.shared.memberShipService.getListAllMembership()
            .showProgressIndicator()
            .subscribe(onNext: { [weak self] (member) in
            self?.outputs.listMembership.value = member
            self?.outputs.listSearchMember.value = member
        }).disposed(by: disposeBag)
    }

    init() {
        inputs.textSearch.asObservable().subscribe(onNext: {[weak self] (textSearch) in
            let listStar = self?.outputs.listSearchMember.value?.startedMemberships.filter { (member) -> Bool in
                guard let _textSearch = textSearch else { return true }
                if _textSearch == "" {
                    return true
                } else {
                    if let _mechant = member.merchant, let _name = _mechant.name {
                        return _name.containsIgnoringCase(_textSearch)
                    }
                    return false
                }
            }
            
            let listOther = self?.outputs.listSearchMember.value?.otherMemberships.filter { (member) -> Bool in
                guard let _textSearch = textSearch else { return true }
                if _textSearch == "" {
                    return true
                } else {
                    if let _mechant = member.merchant, let _name = _mechant.name {
                        return _name.containsIgnoringCase(_textSearch)
                    }
                    return false
                }
            }
            if let _listStar = listStar {
                self?.inputs.listTemp.startedMemberships = _listStar
            }
            if let _listOther = listOther {
                 self?.inputs.listTemp.otherMemberships = _listOther
            }
           
            self?.outputs.listMembership.value = self?.inputs.listTemp
        }).disposed(by: disposeBag)
    }
}
