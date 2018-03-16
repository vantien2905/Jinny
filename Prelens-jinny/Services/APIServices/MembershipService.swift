//
//  MembershipService.swift
//  Prelens-jinny
//
//  Created by Edward Nguyen on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import Alamofire

protocol MembershipServiceProtocol {
    func getListAllMembership() -> Observable<Membership?>
}

class MembershipService: MembershipServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getListAllMembership() -> Observable<Membership?> {
        return network.rx_Object(url: APIEndpoint.Membership.getListAllMembership, method: .get, parameters: [:])
    }
}
