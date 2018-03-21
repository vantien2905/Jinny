//
//  DateOpen.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class DateOpen: NSObject, Mappable {

    var day: String?
    var startTime: String?
    var closeTime: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.day <- map["id"]
        self.startTime <- map["start_time"]
        self.closeTime <- map["close_time"]
    }
    
}

