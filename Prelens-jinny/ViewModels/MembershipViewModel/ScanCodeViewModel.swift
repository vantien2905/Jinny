//
//  ScanCodeViewModel.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/21/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ScanCodeViewModelProtocol {
    var merchant: Variable<Merchant?> { get }
}

class ScanCodeViewModel: ScanCodeViewModelProtocol {
    var merchant: Variable<Merchant?> = Variable<Merchant?>(nil)
}
