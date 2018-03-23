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
        static let changePassword        = "users/change_password"
        static let signOut               = "sessions/sign_out"
    }

    struct Membership {
        static let getListAllMembership = "memberships"
        static let getDetailMembership = "memberships/"
        static let addBookmarkMembership = "memberships/%@/toggle_bookmark"
        static let deleteMembership = "memberships/"
        static let getAllMerchant = "merchants"
        static let addMembership = "memberships"
    }
    
    struct Promotion {
        static let getListAllPromotion   = "vouchers"
    }
    

    struct Merchant {
        static let getMerchantDetail = "merchants/%@/branches"
    }
    struct Profile {
        static let getProfile           = "users/my_profile"
        static let updateProfile        = "users/update_profile"
        static let getRegion            = "residentail_regions"
    }
}
