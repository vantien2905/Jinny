//
//  Provider.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import Alamofire

class Provider {
    static let shared: Provider = {
        return Provider()
    }()

    var session: NetworkSession {
        return SessionManager.default
    }

    var network: NetworkProtocol {
        return Network(session: session)
    }

    var authenticationService: AuthenticationServiceProtocol {
        return AuthenticationService(network: network)
    }

    var memberShipService: MembershipServiceProtocol {
        return MembershipService(network: network)
    }
    
    var promotionService: PromotionServiceProtocol {
        return PromotionService(network: network)
    }
}
