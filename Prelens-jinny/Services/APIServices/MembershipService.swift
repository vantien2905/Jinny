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
    func getDetailMembership(idMember: Int) -> Observable<Member?>
}

class MembershipService: MembershipServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getListAllMembership() -> Observable<Membership?> {
        return network.rx_Object(url: APIEndpoint.Membership.getListAllMembership, method: .get, parameters: [:])
    }
    
    func getDetailMembership(idMember: Int) -> Observable<Member?> {
        let url = APIEndpoint.Membership.getDetailMembership + "\(idMember)"
        return network.rx_Object(url: url, method: .get, parameters: [:])
    }
}
