//
//  Promotion.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Promotion: NSObject, Mappable {
    var id              : Int = 1
    var expiresAt       : String?
    var merchant        : Merchant?
    var image           : Image?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        self.id         <- map["id"]
        self.expiresAt  <- map["expires_at"]
        self.merchant   <- map["merchant"]
        self.image      <- map["image"]
     }
}
