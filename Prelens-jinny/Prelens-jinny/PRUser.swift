//
//  PRUser.swift
//  Prelens-jinny
//
//  Created by Lamp on 11/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import ObjectMapper

class PRUser: NSObject, Mappable {
    var userId: Int?
    var email: String?
    var name: String?
    var phoneNumber: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["UserId"]
        email <- map["Email"]
        name <- map["Name"]
        phoneNumber <- map["phoneNumber"]
    }
    
    override init() {
        super.init()
    }
    
    
}
