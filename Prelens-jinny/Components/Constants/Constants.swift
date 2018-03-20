//
//  Constants.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

struct PRColor {
    // JINNY
    static let mainAppColor         = UIColor(red: 227/255, green: 18/255, blue: 11/255, alpha: 1)
    static let borderColor          = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
    static let backgroundColor      = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    static let emptyMembership      = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1)

    static let lineColor            = UIColor.black.withAlphaComponent(0.1)
    static let blackColor           = UIColor.black
    static let whiteColor           = UIColor.white
    static let navigationBar        = UIColor.white

    static let backgroundPopUp      = UIColor.black.withAlphaComponent(0.6)
}

struct PRImage {
    static let tabbarMembershipOff  = UIImage(named: "membership_off")!
    static let tabbarMembershipOn   = UIImage(named: "membership_on")!
    static let tabbarPromotionsOff  = UIImage(named: "voucher_off")!
    static let tabbarPromotionsOn   = UIImage(named: "voucher_on")!
    static let tabbarMore           = UIImage(named: "more")!
    static let imgBack              = UIImage(named: "back_black")!
    static let imgStarOff              = UIImage(named: "star_action_off")!
    static let imgStarOn              = UIImage(named: "star_action_on")!
    static let imgNext              = UIImage(named: "next_gray")!
}

struct Cell {
    static let searchMemberShip = "SearchMembershipCell"
    static let emptyMembership = "EmptyMembershipCell"
    static let memberShip = "MembershipCell"
    static let starredheader = "StarredHeaderCell"
    static let otherHeader  = "OtherHeaderCell"
    static let membershipFooter = "MembershipFooterCell"
    static let membershipDetail    = "MembershipDetailCell"
    static let headerMemBershipDetail = "HeaderMembershipDetailCell"
    static let footerMembershipDetail = "FooterMembershipDetailCell"

    //Merchant
    static let merchantDetail   = "MerchantDetailCell"
    static let promotionDetailCell = "PromotionDetailCell"
    static let promotionDetailHeaderCell = "PromotionDetailHeaderCell"
    static let promotionDetailFooterCell = "PromotionDetailFooterCell"
    static let addMerchantCell = "AddMerchantCell"

    static let promotionHeader  = "PromotionHeaderCell"
    static let promotionCell    = "PromotionCell"
    static let searchPromotion  = "SearchPromotionCell"
    static let emptyPromotion   = "EmptyPromotionCell"
}

struct PRFont {
    static let sideBarMenuFont = UIFont(name: "SegoeUI-Semibold", size: 15)
    static let semiBold15   = UIFont(name: "SegoeUI-Semibold", size: 15)
}

struct ContantMessages {
    struct Login {
        static let errorContentPassword =  "Password is too short (minimum is 6 characters)"
        static let successResetPassword =  "You will receive an email with instructions on how to reset your password in a few minutes"
    }

    struct User {
        static let successChangePassword = "Your password has been changed successfully"
    }
}

struct ConstantString {
    struct Membership {
        static let emptyStarMembership = "Keep you frequently used membership here by starring it"
        static let emptyOtherMembership = "Press the + button below to add new membership"
    }
}
