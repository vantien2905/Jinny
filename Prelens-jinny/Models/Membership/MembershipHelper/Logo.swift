//
//  Logo.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Logo: NSObject, Mappable {
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
