//
//  NetworkResponse.swift
//  Prelens-jinny
//
//  Created by Lamp on 9/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class BaseResponse: Mappable {
    
    var status  : String?
    var message : String?
    var code    : Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["error_message"]
        code    <- map["code"]
    }
    
    var isSuccess: Bool {
        return (status == "OK" ? true : false)
    }
    
    var forbidden: Bool {
        return (code == 401 || code == 403)
    }
    
    var getData: Any {
        guard let _status = status else { return "" }
        return _status
    }
}
