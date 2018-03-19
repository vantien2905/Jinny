//
//  Url.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Url: NSObject, Mappable {

    var thumb: String?
    var medium: String?
    var original: String?

    override init() {
        super.init()
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.thumb <- map["thumb"]
        self.medium <- map["medium"]
        self.original <- map["original"]
    }
}
