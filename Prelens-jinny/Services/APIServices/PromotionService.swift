//
//  PromotionService.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//
import RxSwift
import Alamofire

protocol PromotionServiceProtocol {
    func getListAllPromotion() -> Observable<Promotion?>
}

class PromotionService: PromotionServiceProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getListAllPromotion() -> Observable<Promotion?> {
        return network.rx_Object(url: APIEndpoint.Promotion.getListAllPromotion, method: .get, parameters: [:])
    }
    
}
