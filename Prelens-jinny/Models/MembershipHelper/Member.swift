//
//  Member.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Member: NSObject, Mappable {
    
    var id: String?
    var merchant: Merchant?
    var code: String?
    var addedDate: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.merchant <- map["merchant"]
        self.code <- map["code"]
        self.addedDate <- map["added_date"]
    }
}
