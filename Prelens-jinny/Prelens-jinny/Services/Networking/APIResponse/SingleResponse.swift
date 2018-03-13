//
//  SingleResponse.swift
//  Prelens-jinny
//
//  Created by Lamp on 9/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class SingleResponse<T: Mappable>: BaseResponse {
    
    var data: T?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["result"]
    }
    
    override var getData: Any {
        return data as Any
    }
    
}

