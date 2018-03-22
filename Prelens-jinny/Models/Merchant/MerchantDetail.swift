//
//  MerchantDetail.swift
//  Prelens-jinny
//
//  Created by Lamp on 21/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class MerchantDetail: NSObject, Mappable {
    var id: Int = 0
    var address: String?
    var name: String?
    var merchantId: Int = 0
    var createdAt: String?
    var openHours: [DateOpen]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.address <- map["address"]
        self.merchantId <- map["merchant_id"]
        self.createdAt <- map["created_at"]
        self.openHours <- map["opening_hours"]
    }
}
