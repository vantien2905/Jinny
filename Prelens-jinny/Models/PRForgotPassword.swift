//
//  PRForgotPassword.swift
//  Prelens-jinny
//
//  Created by vinova on 3/15/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class PRForgotPassword: NSObject, Mappable {
    
    var message: String?
    var status: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.status  <- map["status"]
    }
}
