//
//  PRUser.swift
//  Prelens-jinny
//
//  Created by Lamp on 12/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class PRUser: NSObject, Mappable {
    var id          : String?
    var email       : String?
    var fullName    : String?
    var dob         : Date?
    var gender      : String?
    var token       : String?
    var resRegion   : Int?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id         <- map["id"]
        self.gender     <- map["gender"]
        self.email      <- map["email"]
        self.fullName   <- map["full_name"]
        self.token      <- map["token"]
        self.dob        <- map["dob"]
        self.resRegion  <- map["residential_region"]
    }
    
    func getToken() -> String {
        let apiToken = token ?? ""
        return apiToken
    }
}

