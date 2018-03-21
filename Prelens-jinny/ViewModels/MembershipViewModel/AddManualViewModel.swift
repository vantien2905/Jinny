//
//  AddManualViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift

protocol AddManualViewModelProtocol {
    var urlLogo: Variable<Url?> { get }
}

class AddManualViewModel: AddManualViewModelProtocol {
    var urlLogo: Variable<Url?> = Variable<Url?> (nil)
}
