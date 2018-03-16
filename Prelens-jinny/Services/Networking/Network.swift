//
//  Networking.swift
//  iOSBase
//
//  Created by Edward Nguyen on 3/15/18.
//  Copyright © 2018 sg.vinova.iOSBAse. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON
import ObjectMapper

protocol NetworkProtocol {
    func rx_Object<T: Mappable>(url: String, method: HTTPMethod, body: [String: AnyObject]?, header: [String: String]?) -> Observable<T?>
    func rx_Array<T: Mappable>(url: String, method: HTTPMethod, body: [String: AnyObject]?, header: [String: String]?) -> Observable<[T]>
}

class Network: NetworkProtocol {
    
    let session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func handleUrl(_ path: String) -> String {
        return "\(APIURL.baseURL)\(path)"
    }
    
    func getAlamofireUrlEncoding(method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func rx_Object<T: Mappable>(url: String, method: HTTPMethod, body: [String: AnyObject]?, header: [String: String]?) -> Observable<T?> {
        let urlRequest = self.handleUrl(url)
        let encoding = self.getAlamofireUrlEncoding(method: method)
        return session.request(urlRequest, method: method, parameters: body, encoding: encoding, headers: header).map {(response)  in
            let json = JSON(response.data)
            let jsonData = json["result"]
            return Mapper<T>().map(JSONObject: jsonData.dictionaryObject)
        }
    }
    
    func rx_Array<T: Mappable>(url: String, method: HTTPMethod, body: [String: AnyObject]?, header: [String: String]?) -> Observable<[T]> {
        let urlRequest = self.handleUrl(url)
        let encoding = self.getAlamofireUrlEncoding(method: method)
        
        return session.request(urlRequest, method: method, parameters: body, encoding: encoding, headers: header)
            .map {(response)  in
                let json = JSON(response.data)
                let jsonData = json["result"]
                return Mapper<T>().mapArray(JSONObject: jsonData.arrayObject) ?? []
        }
    }
    
}
