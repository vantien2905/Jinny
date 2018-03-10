//
//  ArrayResponse.swift
//  Prelens-jinny
//
//  Created by Lamp on 9/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class ArrayResponse<T: Mappable>: BaseResponse {
    
    var data: [T]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
    
    override var getData: Any {
        return data as Any
    }
    
}
