//
//  Member.swift
//  Prelens-jinny
//
//  Created by Felix Dinh on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class Member: NSObject, Mappable {

    var id: Int = 1
    var merchant: Merchant?
    var code: String?
    var addedDate: String?
    var hasBookmark: Bool = false
    var vouchers: [Promotion]?

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
        self.hasBookmark <- map["has_bookmark"]
        self.vouchers <- map["vouchers"]
    }
}

extension Member: Comparable {
    public static func >(lhs: Member, rhs: Member) -> Bool {
        guard let lhsDate = lhs.merchant?.createdDate else { return false }
        guard let rhsDate = rhs.merchant?.createdDate else { return true }
        return lhsDate > rhsDate
    }
    
    public static func <(lhs: Member, rhs: Member) -> Bool {
        guard let lhsDate = lhs.merchant?.createdDate else { return true }
        guard let rhsDate = rhs.merchant?.createdDate else { return false }
        return lhsDate < rhsDate
    }
    
    public static func ==(lhs: Member, rhs: Member) -> Bool {
        guard let lhsDate = lhs.merchant?.createdDate else { return false }
        guard let rhsDate = rhs.merchant?.createdDate else { return false }
        return lhsDate == rhsDate
    }
}
