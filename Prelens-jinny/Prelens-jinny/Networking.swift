//
//  Networking.swift
//  Prelens-jinny
//
//  Created by Lamp on 7/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import ObjectMapper

enum ServiceError: Error {
    case InvalidJSON
    case InvalidToken
}

class ApiError: Swift.Error {
    let code: Int
    let description: String
    
    init(errorCode: Int, errorMessage: String){
        self.code = errorCode
        self.description = errorMessage
    }
}

enum KeyApi: String {
    case errorMessage = "ErrorMessage"
    case erorCode = "ErrorCode"
    case isError = "IsError"
}

class Networking {
    static let shared: Networking = {
        let instance = Networking()
        return instance
    }()
    
    var currentToken: String = ""
    
    class func headers() -> [String: String]? {
        if Networking.shared.currentToken.isEmpty {
            if let token = KeychainManager.shared.getToken() {
                Networking.shared.currentToken = token
            }
        }
        return ["AccessToken": Networking.shared.currentToken, "Content-Type": "application/json"]
    }
    
    class func getAlamofireUrlEncoding(method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    class func checkValid() {

    }
    
    class func reLogin() {   // -> Observable<Bool> {
        
    }
    
    
    
}
