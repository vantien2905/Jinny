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
    
    
    
    
    static let extensionColor       = UIColor(red: 202/255, green: 186/255, blue: 99/255, alpha: 1)
    
    static let reminderColor        = UIColor(red: 222/255, green: 243/255, blue: 68/255, alpha: 1)
    static let pendingReviewColor   = UIColor(red: 27/255, green: 123/255, blue: 52/255, alpha: 1)
    static let textAppGuide         = UIColor(red: 181/255, green: 181/255, blue: 181/255, alpha: 1)
    
    static let taskInProgressColor  = UIColor(red: 31/255, green: 181/255, blue: 143/255, alpha: 1)
    static let taskOverdueColor     = UIColor(red: 242/255, green: 76/255, blue: 76/255, alpha: 1)
    static let taskCompletedColor   = UIColor(red: 110/255, green: 109/255, blue: 105/255, alpha: 1)
    static let taskNewColor         =  UIColor(red: 234/255, green: 177/255, blue: 38/255, alpha: 1)
    
    static let btnColorBlue         =  UIColor(red: 40/255, green: 172/255, blue: 172/255, alpha: 1)
    static let reviewed             = UIColor(red: 27/255.0, green: 123/255.0, blue: 52/255.0, alpha: 1.0)
    static let inCompleted          = UIColor(red: 242/255.0, green: 76/255.0, blue: 78/255.0, alpha: 1.0)
    static let strokeTextField      =  UIColor(red: 99/255, green: 189/255, blue: 202/255, alpha: 1)
    static let filterAssignee       = UIColor(red: 44/255, green: 141/255, blue: 156/255, alpha: 1)
    static let manageReviewerColor  = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    
    //--- notification
    static let sttReminder          = UIColor(red: 222/255, green: 116/255, blue: 69/255, alpha: 1)
    static let sttUpdates           = UIColor(red: 22/255, green: 167/255, blue: 157/255, alpha: 1)
    static let sttExtensionRequest  = UIColor(red: 202/255, green: 186/255, blue: 99/255, alpha: 1)
    static let badgeNotification    = UIColor(red: 99/255, green: 189/255, blue: 202/255, alpha: 1)
    static let switchSetting        = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    static let notificationLine     = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
    
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
}

struct Cell {
    static let searchMemberShip = "SearchMembershipCell"
    static let emptyMembership = "EmptyMembershipCell"
    static let memberShip = "MembershipCell"
    static let starredheader = "StarredHeaderCell"
    static let otherHeader  = "OtherHeaderCell"
    static let membershipFooter = "MembershipFooterCell"
    static let membershipDetail    = "MembershipDetailCell"
}

struct PRFont {
    static let sideBarMenuFont = UIFont(name: "SegoeUI-Semibold", size: 15)
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





