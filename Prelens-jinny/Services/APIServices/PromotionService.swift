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
    func getListAllPromotion() -> Observable<[Promotion]>
    func addBookmarkVoucher(idBookmark: Int) -> Observable<Promotion?>
    func getPromotionDetail(id: Int) -> Observable<PromotionDetail?>
}

class PromotionService: PromotionServiceProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getListAllPromotion() -> Observable<[Promotion]> {
        return network.rx_Array(url: APIEndpoint.Promotion.getListAllPromotion, method: .get, parameters: [:])
    }
    
    func addBookmarkVoucher(idBookmark: Int) -> Observable<Promotion?> {
        var _url = APIEndpoint.Promotion.addBookmarkVoucher
        _url = String(format: _url, "\(idBookmark)")
        return network.rx_Object(url: _url, method: .put, parameters: [:])
    }
    
    func getPromotionDetail(id: Int) -> Observable<PromotionDetail?> {
        var _url = APIEndpoint.Promotion.getPromotionDetail
        _url = String(format: _url, "\(id)")
        return network.rx_Object(url: _url, method: .get, parameters: [:])
    }
}
