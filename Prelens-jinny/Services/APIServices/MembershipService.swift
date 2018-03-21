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
    func addBookmarkMembership(idBookmark: Int) -> Observable<Member?>
    func deleteMembership(idDelete: Int) -> Observable<Member?>
    func getAllMerchants(page: Int, perPage: Int) -> Observable<[Merchant]>
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

    func addBookmarkMembership(idBookmark: Int) -> Observable<Member?> {
        var _url = APIEndpoint.Membership.addBookmarkMembership
        _url = String(format: _url, "\(idBookmark)")
        return network.rx_Object(url: _url, method: .post, parameters: [:])
    }
    
    func deleteMembership(idDelete: Int) -> Observable<Member?> {
        let _url = APIEndpoint.Membership.deleteMembership + "\(idDelete)"
        return network.rx_Object(url: _url, method: .delete, parameters: [:])
    }
    
    func getAllMerchants(page: Int, perPage: Int) -> Observable<[Merchant]> {
        let url = APIEndpoint.Membership.getAllMerchant
        return network.rx_Array(url: url, method: .get, parameters: [:])
    }
}
