//
//  MembershipDetailViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MembershipDetailViewModelProtocol {
    var idMembership: Variable<Int> { get }
    var isBookmark: Variable<Bool>  { get }
    var membership: Variable<Member?> { get }
    var isBookmarkSucess: Variable<Bool> { get }
}

class MembershipDetailViewModel: MembershipDetailViewModelProtocol {
    var idMembership: Variable<Int> = Variable<Int>(0)
    var isBookmark: Variable<Bool> = Variable<Bool> (false)
    var membership: Variable<Member?> = Variable<Member?>(nil)
    var isBookmarkSucess: Variable<Bool> = Variable<Bool> (false)
    
    let disposeBag = DisposeBag()

    init(idMember: Int) {
        self.idMembership.value = idMember
        
        idMembership.asObservable().subscribe(onNext: { [weak self] idMember in
            self?.getDetailMembership(idMember: idMember)
        }).disposed(by: disposeBag)
        isBookmark.asObservable().subscribe(onNext: { (_) in
            self.addBookmarkMembership(idMember: idMember)
        }).disposed(by: disposeBag)
        
        
    }
    
    func getDetailMembership(idMember: Int) {
        Provider.shared.memberShipService.getDetailMembership(idMember: idMember).subscribe(onNext: { [weak self] (membership) in
            self?.membership.value = membership
            }).disposed(by: disposeBag)
    }
    
    func addBookmarkMembership(idMember: Int) {
//        Provider.shared.memberShipService.addBookmarkMembership(id: idMember).subscribe(onNext: { (<#Member?#>) in
//            <#code#>
//        }, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
