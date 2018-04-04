//
//  Router.swift
//  Prelens-jinny
//
//  Created by vinova on 4/4/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
enum Route {
    case tab(Tabbar)
    case signIn
    case signUp
    
    enum Tabbar: Int {
        case membership = 0
        case vouchers = 1
        case more = 2
    }
    
    init(tabbar: Tabbar) {
        self = .tab(tabbar)
    }
}

