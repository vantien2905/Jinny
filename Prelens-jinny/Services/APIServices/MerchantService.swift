//
//  MerchantService.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import Alamofire

protocol MerchantServiceProtocol {
    func getMerchantDetail(idMerchant: Int) -> Observable<[MerchantDetail]>
}

class MerchantService: MerchantServiceProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getMerchantDetail(idMerchant: Int) -> Observable<[MerchantDetail]> {
        var url = APIEndpoint.Merchant.getMerchantDetail
        url = String(format: url, "\(idMerchant)")
        return network.rx_Array(url: url, method: .get, parameters: [:])
    }
}
