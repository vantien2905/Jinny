//
//  EditProfileViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileViewModel {
    let disposeBag = DisposeBag()
    
    class EditProfileViewModelInput {
        
    }
    
    class EditProfileViewModelOutput {
        var user = Variable<PRUser?>(nil)
    }
    
    var inputs = EditProfileViewModelInput()
    var outputs = EditProfileViewModelOutput()
    
    func getProfile() {
        Provider.shared.profileService.getProfile().subscribe(onNext: { [weak self] (user) in
            self?.outputs.user.value = user
        }).disposed(by: disposeBag)
    }
}
