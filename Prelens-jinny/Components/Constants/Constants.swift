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
    static let searchColor   = UIColor(red: 110/255, green: 109/255, blue: 105/255, alpha: 1)
    
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
    static let imgWhiteBack         = UIImage(named: "back_white")!
    static let imgStarOff           = UIImage(named: "star_action_off")!
    static let imgStarOn            = UIImage(named: "star_action_on")!
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
    static let merchantDetailHeaderCell = "MerchantDetailHeaderCell"
    static let merchantBranchCell = "MerchantBranchCell"
    
    static let promotionDetailCell = "PromotionDetailCell"
    static let promotionDetailHeaderCell = "PromotionDetailHeaderCell"
    static let promotionDetailFooterCell = "PromotionDetailFooterCell"
    static let addMerchantCell = "AddMerchantCell"
    static let voucherRedeemFooterCell = "RedeemVoucherFooterCell"

    static let promotionHeader  = "PromotionHeaderCell"
    static let promotionCell    = "PromotionCell"
    static let searchPromotion  = "SearchPromotionCell"
    static let emptyPromotion   = "EmptyPromotionCell"
    
    //Custom View
    static let selectDataCell   = "SelectDataPopUpCell"
}

struct PRFont {
    static let sideBarMenuFont = UIFont(name: "SegoeUI-Semibold", size: 15)
    static let semiBold15   = UIFont(name: "SegoeUI-Semibold", size: 15)
    static let regular15    = UIFont(name: "SegoeUI", size: 15)
}

struct ContantMessages {
    struct Login {
        static let errorInvalidEmail    =  "Email is invalid"
        static let errorContentPassword =  "Password is too short (minimum is 6 characters)"
        static let successResetPassword =  "You will receive an email with instructions on how to reset your password in a few minutes"
        static let errorUncheckedCondition = "Please indicate that you have agree to the Terms and Conditions"
        static let errorEmptyInputValue    =  "Please enter your email & password"
        static let errorEmptyEmail        =   "Email can't be blank"
        static let errorEmptyPassword     =   "Password can't be blank"
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
