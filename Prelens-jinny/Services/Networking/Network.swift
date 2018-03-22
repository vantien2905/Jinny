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
    func rx_Object<T: Mappable>(url: String, method: HTTPMethod, parameters: [String: AnyObject]?) -> Observable<T?>
    func rx_Array<T: Mappable>(url: String, method: HTTPMethod, parameters: [String: AnyObject]?) -> Observable<[T]>
}

class Network: NetworkProtocol {

    let session: NetworkSession

    var header: HTTPHeaders {
        var token: String = ""
        if let _token = KeychainManager.shared.getToken() {
            token = _token
        }
        let headers = [
            "Jinny-Http-Token": token, //this will be assigned from user model
            "Accept": "application/json"
        ]
        return headers
    }

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

    func rx_Object<T: Mappable>(url: String, method: HTTPMethod, parameters: [String: AnyObject]?) -> Observable<T?> {
        let urlRequest = self.handleUrl(url)
        let encoding = self.getAlamofireUrlEncoding(method: method)
        return session.request(urlRequest, method: method, parameters: parameters, encoding: encoding, headers: header).map {(response)  in
            let json = JSON(response.data)
            let jsonData = json["result"]
            return Mapper<T>().map(JSONObject: jsonData.dictionaryObject)
        }
    }

    func rx_Array<T: Mappable>(url: String, method: HTTPMethod, parameters: [String: AnyObject]?) -> Observable<[T]> {
        let urlRequest = self.handleUrl(url)
        let encoding = self.getAlamofireUrlEncoding(method: method)

        return session.request(urlRequest, method: method, parameters: parameters, encoding: encoding, headers: header)
            .map {(response)  in
                let json = JSON(response.data)
                let jsonData = json["result"]
                return Mapper<T>().mapArray(JSONObject: jsonData.arrayObject) ?? []
        }
    }

}
