//
//  APIUserService.swift
//  Prelens-jinny
//
//  Created by vinova on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import RxSwift

class APIUserService: APIBaseService {
    func changePassword(curPassword: String, newPassword: String) -> Observable<SingleResponse<PRUser>> {
        let _fullPath = baseURL.appending(APIEndpoint.User.changePassword)
        let params = [
            "current_password": curPassword,
            "new_password": newPassword
        ]
        let requestInfo = RequestInfo(headers: header, fullPath: _fullPath, params: params, method: .put)
        
        return execute(requestInfo, responseType: SingleResponse<PRUser>.self)
    }
}

