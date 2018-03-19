//
//  PRTabbarCustom.swift
//  Prelens-jinny
//
//  Created by Lamp on 15/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

protocol PRTabbarCustomDelegate: class {
    func btnTapped(tag: Int)
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
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vMore.setIcon(image: PRImage.tabbarMore)
        case 1:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOn)
            vMore.setIcon(image: PRImage.tabbarMore)
        case 2:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vMore.setIcon(image: PRImage.tabbarMore)
            
        default:
            vMemberships.setIcon(image: PRImage.tabbarMembershipOff)
            vPromotions.setIcon(image: PRImage.tabbarPromotionsOff)
            vMore.setIcon(image: PRImage.tabbarMore)
        }
    }
}

extension PRTabbarCustom: PRTabbarButtonDelegate {
    func btnTapped(name: String) {
        switch name {
        case "Memberships":
            buttonTappedDelegate?.btnTapped(tag: 0)
        case "Promotions":
            buttonTappedDelegate?.btnTapped(tag: 1)
        case "More":
            buttonTappedDelegate?.btnTapped(tag: 2)
        default:
            break
        }
    }
}






