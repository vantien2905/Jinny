//
//  TestingService.swift
//  Prelens-jinny
//
//  Created by Lamp on 12/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import RxSwift

class TestingService: APIBaseService {
    
    func getDataRequestInfo() -> Observable<SingleResponse<PRUser>> {
        let fullPath = APIBaseService._serverPath.appending("123123")
        let param = ["":""]
        let request = RequestInfo(headers: nil, fullPath: fullPath, params: param, method: .get)
        
        return execute(request, responseType: SingleResponse<PRUser>.self)
    }
    
}

