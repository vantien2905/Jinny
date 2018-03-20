//
//  Image.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper
class Image: NSObject, Mappable {
    var url: Url?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.url <- map["url"]
    }
}
