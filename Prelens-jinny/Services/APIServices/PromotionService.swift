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
    
    func getListAllPromotion(order: String) -> Observable<[Promotion]>
    func getPromotionDetail(id: String) -> Observable<PromotionDetail?>
    func getListStarredPromotion(order: String)  -> Observable<[Promotion]>
    func getListAchivedPromotion(order:String) -> Observable<[Promotion]>
    
    func addBookmarkVoucher(idBookmark: String) -> Observable<Promotion?>
    func addVoucher(code: String) -> Observable<PromotionDetail?>
    func removeVoucher(idVoucher: String) -> Observable<PromotionDetail?>
    func redeemVoucher(idVoucher: String) -> Observable<PromotionDetail?>
    
}

class PromotionService: PromotionServiceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getListAllPromotion(order: String) -> Observable<[Promotion]> {
         let param = ["order" : order]  as [String : AnyObject]
        return network.rx_Array(url: APIEndpoint.Promotion.getListAllPromotion, method: .get, parameters: param)
    }
    
    func getPromotionDetail(id: String) -> Observable<PromotionDetail?> {
        var _url = APIEndpoint.Promotion.getPromotionDetail
        _url = String(format: _url, "\(id)")
        return network.rx_Object(url: _url, method: .get, parameters: [:])
    }
    
    func getListStarredPromotion(order:String) -> Observable<[Promotion]> {
        let param = ["order" : order]  as [String : AnyObject]
        return network.rx_Array(url: APIEndpoint.Promotion.getListStarredPromotion,
                                method: .get, parameters: param)
    }
    
    func getListAchivedPromotion(order:String) -> Observable<[Promotion]> {
        let param = ["order" : order]  as [String : AnyObject]
        return network.rx_Array(url: APIEndpoint.Promotion.getListAchivedPromotion, method: .get, parameters: param)
    }
    
    func addBookmarkVoucher(idBookmark: String) -> Observable<Promotion?> {
        var _url = APIEndpoint.Promotion.addBookmarkVoucher
        _url = String(format: _url, "\(idBookmark)")
        return network.rx_Object(url: _url, method: .put, parameters: [:])
    }
    
    func addVoucher(code: String) -> Observable<PromotionDetail?> {
        let param = ["key" : code]  as [String : AnyObject]
        return network.rx_Object(url: APIEndpoint.Promotion.addVoucher, method: .post, parameters: param)
    }
    
    func removeVoucher(idVoucher: String) -> Observable<PromotionDetail?> {
        var _url = APIEndpoint.Promotion.removeVoucher
        _url = String(format: _url, "\(idVoucher)")
        let param = ["id" : idVoucher]  as [String : AnyObject]
        return network.rx_Object(url: _url, method: .delete, parameters: param)
    }
    
    func redeemVoucher(idVoucher: String) -> Observable<PromotionDetail?> {
        var _url = APIEndpoint.Promotion.redeemVoucher
        _url = String(format: _url, "\(idVoucher)")
        let param = ["id" : idVoucher] as [String: AnyObject]
        return network.rx_Object(url: _url, method: .post, parameters: param)
    }
    
}
