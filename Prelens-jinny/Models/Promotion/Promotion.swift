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
    var promotionDescription: String?
    var expiresAt       : String?
    var expiresString   : String?
    var isReaded        : Bool = true
    var isBookMarked    : Bool = false
    var merchant        : Merchant?
    var expiresDate: Date? {
        return Date.dateFromString(expiresString)
    }
    var image           : Image?
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        self.id         <- map["id"]
        self.promotionDescription <- map["description"]
        self.expiresAt  <- map["expires_at"]
        self.expiresString <- map["expires_at_in_words"]
        self.merchant   <- map["merchant"]
        self.isReaded   <- map["is_readed"]
        self.image      <- map["image"]
        self.isBookMarked <- map["is_bookmarked"]
     }
}
