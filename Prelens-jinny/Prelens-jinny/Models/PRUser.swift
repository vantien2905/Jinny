//
//  PRUser.swift
//  Prelens-jinny
//
//  Created by Lamp on 12/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import ObjectMapper

class PRUser: NSObject, Mappable {
    var name: String?
    var idUser: Int?
    
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.idUser <- map["idUser"]
    }
}
