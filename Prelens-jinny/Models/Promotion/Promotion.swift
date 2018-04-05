//
//  Promotion.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Promotion: NSObject, Mappable {
    var id              : String?
    var promotionDescription: String?
    var expiresAt       : Date?
    var expiresString   : String?
    var isReaded        : Bool = false
    var isBookMarked    : Bool = false
    var merchant        : Merchant?
    var image           : Image?
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale     = .current
        dateFormatter.timeZone   = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.id                     <- map["id"]
        self.promotionDescription   <- map["description"]
        self.expiresAt              <- (map["expires_at"],DateFormatterTransform(dateFormatter: dateFormatter))
        self.expiresString          <- map["expires_at_in_words"]
        self.merchant               <- map["merchant"]
        self.isReaded               <- map["is_read"]
        self.image                  <- map["image"]
        self.isBookMarked           <- map["is_bookmarked"]
     }
}

