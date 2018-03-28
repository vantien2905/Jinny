//
//  PromotionDetail.swift
//  Prelens-jinny
//
//  Created by Lamp on 26/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class PromotionDetail: NSObject, Mappable {
    var id                      : Int = 0
    var detailDescription        : String?
    var expireAt                : String?
    var expireAtString          : String?
    var isReaded                : Bool = false
    var isBookmarked            : Bool = false
    var image                   : [Image]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.detailDescription <- map["description"]
        self.expireAt <- map["expires_at"]
        self.expireAtString <- map["expires_at_in_words"]
        self.isReaded <- map["is_readed"]
        self.isBookmarked <- map["is_bookmarked"]
        self.image <- map["image"]
    }
}
