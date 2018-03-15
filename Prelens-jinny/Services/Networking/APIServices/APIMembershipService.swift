//
//  APIMembershipService.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import RxSwift

class APIMembershipService: APIBaseService {
    func getListAllMembership() -> Observable<SingleResponse<Membership>> {
        let _fullPath = baseURL.appending(APIEndpoint.Membership.getListAllMembership)
        
        
        let requestInfo = RequestInfo(headers: header, fullPath: _fullPath, params: [:], method: .get)
        
        return execute(requestInfo, responseType: SingleResponse<Membership>.self)
    }
    
}
