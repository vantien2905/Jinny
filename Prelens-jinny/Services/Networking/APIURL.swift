//
//  APIURL.swift
//  iOSBase
//
//  Created by Edward Nguyen on 3/15/18.
//  Copyright © 2018 sg.vinova.iOSBAse. All rights reserved.
//

struct APIURL {
    static let baseURL = "http://jinny.vinova.sg/api/v1/"
}

struct APIEndpoint {
    struct Authentication {
        static let login                 = "sessions/sign_in"
        static let signUp                = "users/sign_up"
        static let forgotPassword        = "users/forgot_password"
    }
    
    struct Membership {
        static let getListAllMembership = "memberships"
    }
}
