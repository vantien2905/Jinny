//
//  Merchant.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Merchant: NSObject, Mappable {
    var id: Int = 0
    var name: String?
    var descriptions: String?
    var logo: Logo?
    var createdAt: String?

    override init() {
        super.init()
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.descriptions <- map["description"]
        self.createdAt <- map["created_at"]
        self.logo <- map["logo"]

    }

}
