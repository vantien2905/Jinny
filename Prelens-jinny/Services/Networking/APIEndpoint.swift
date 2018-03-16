//
//  APIEndpoint.swift
//  Prelens-jinny
//
//  Created by Lamp on 8/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import Foundation

public let baseURL = "http://jinny.vinova.sg"

struct APIEndpoint {
    struct Authentication {
        static let signIn           = "/api/v1/sessions/sign_in"
        static let signUp           = "/api/v1/users/sign_up"
        static let forgotPassword   = "/api/v1/users/forgot_password"
    }
    
    struct Membership {
        static let getListAllMembership = "/api/v1/memberships"
        static let getMembershipDetail = "/api/v1/memberships/"
        static let addBookmarkMembership = "/api/v1/memberships/%@/toggle_bookmark"
    }
}
