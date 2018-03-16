//
//  ResidentialRegion.swift
//  Prelens-jinny
//
//  Created by vinova on 3/16/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation
import ObjectMapper

class ResidentialRegion: NSObject, Mappable {
    var id          : Int?
    var name        : String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        self.id         <- map["id"]
        self.name       <- map["name"]
    }
}
