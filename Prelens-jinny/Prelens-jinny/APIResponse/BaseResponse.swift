//
//  NetworkResponse.swift
//  Prelens-jinny
//
//  Created by Lamp on 9/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class BaseResponse: Mappable {
    
    var status  : Int?
    var message : String?
    var code    : Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        code    <- map["code"]
    }
    
    var isSuccess: Bool {
        return (status == 1 ? true : false)
    }
    
    var forbidden: Bool {
        return (code == 401 || code == 403)
    }
    
    var getData: Any {
        guard let _status = status else { return "" }
        return _status
    }
}
