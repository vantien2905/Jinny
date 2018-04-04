//
//  NetworkSession.swift
//  iOSBase
//
//  Created by Edward Nguyen on 3/15/18.
//  Copyright © 2018 sg.vinova.iOSBAse. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire

protocol NetworkSession {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<Response>
}

extension SessionManager: NetworkSession {
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<Response> {
        print(url)
        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .rx
            .responseData()
            .map { (response, data) -> Response in
                let responseData = Response(statusCode: response.statusCode, data: data)
                if let error = ApiError(response: responseData) {
                    throw error
                }
                return responseData
        }
    }
}
