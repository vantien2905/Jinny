//
//  Membership.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import ObjectMapper

class Membership: NSObject, Mappable {

    var startedMemberships = [Member]()
    var otherMemberships = [Member]()

    override init() {
        super.init()
    }

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.startedMemberships <- map["started_memberships"]
        self.otherMemberships <- map["other_memberships"]
    }
}
