//
//  PRTabbarCustom.swift
//  Prelens-jinny
//
//  Created by Lamp on 15/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PRTabbarCustomDelegate: class {
    func btnTapped(tag: Route.Tabbar)
}

class PRTabbarCustom: PRBaseViewXib {

    @IBOutlet weak var vMemberships: PRButtonTabbar!
    @IBOutlet weak var vPromotions: PRButtonTabbar!
    @IBOutlet weak var vMore: PRButtonTabbar!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    weak var buttonTappedDelegate: PRTabbarCustomDelegate?

    func setUpView() {
        vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
        vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
        vMore.setIcon(image: PRImage.tabbarMore)

        vMemberships.tabbarButtonDelegate = self
        vPromotions.tabbarButtonDelegate = self
        vMore.tabbarButtonDelegate = self
    }

    func setIndexSelected(index: Int) {
        switch index {
        case 0:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOn)
            vMemberships.lbTitle.textColor = PRColor.mainAppColor
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vPromotions.lbTitle.textColor = UIColor.black.withAlphaComponent(0.5)
            vMore.setIcon(image: PRImage.tabbarMore)
        case 1:
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOn)
            vPromotions.lbTitle.textColor = PRColor.mainAppColor
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vMemberships.lbTitle.textColor = UIColor.black.withAlphaComponent(0.5)
            vMore.setIcon(image: PRImage.tabbarMore)
        case 2:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vMore.lbTitle.textColor = UIColor.black.withAlphaComponent(0.5)
            vMore.setIcon(image: PRImage.tabbarMore)

        default:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vMore.lbTitle.textColor = UIColor.black.withAlphaComponent(0.5)
            vMore.setIcon(image: PRImage.tabbarMore)
        }
    }
}

extension PRTabbarCustom: PRTabbarButtonDelegate {
    func btnTapped(name: String) {
        switch name {
        case "Memberships":
            buttonTappedDelegate?.btnTapped(tag: Route.Tabbar.membership)
        case "Vouchers":
            buttonTappedDelegate?.btnTapped(tag: Route.Tabbar.vouchers)
        case "More...":
            buttonTappedDelegate?.btnTapped(tag: Route.Tabbar.more)
        default:
            break
        }
    }
}
