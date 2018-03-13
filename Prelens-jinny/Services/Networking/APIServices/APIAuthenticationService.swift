//
//  APISignInService.swift
//  Prelens-jinny
//
//  Created by Lamp on 12/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import RxSwift

class APIAuthenticationService: APIBaseService {
    func signIn(email: String, password: String) -> Observable<SingleResponse<PRUser>> {
        let _fullPath = baseURL.appending(APIEndpoint.Authentication.signIn)
        let params = [
            "email": email,
            "password": password
        ]
        let requestInfo = RequestInfo(headers: header, fullPath: _fullPath, params: params, method: .post)
        
        return execute(requestInfo, responseType: SingleResponse<PRUser>.self)
    }
    
    func signUp(email: String, password: String) -> Observable<SingleResponse<PRUser>> {
        let _fullPath = baseURL.appending(APIEndpoint.Authentication.signUp)
        let params = [
            "email": email,
            "password": password
        ]
        let requestInfo = RequestInfo(headers: header, fullPath: _fullPath, params: params, method: .post)
        
        return execute(requestInfo, responseType: SingleResponse<PRUser>.self)
    }
}


