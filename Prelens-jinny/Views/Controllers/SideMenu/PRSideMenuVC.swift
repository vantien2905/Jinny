//
//  PRSideMenuVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 14/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit

class PRSideMenuVC: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var vAccount: UIView!
    
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    @IBOutlet weak var lbEditProfile: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    
    @IBOutlet weak var lbSetting: UILabel!
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var lbTermsAndConditions: UILabel!
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    
    @IBOutlet weak var lbPrivacy: UILabel!
    @IBOutlet weak var btnPrivacy: UIButton!
    
    @IBOutlet weak var lbLogout: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        setUpView()
    }
    
    func setUpView() {
        vAccount.backgroundColor = PRColor.mainAppColor
        
        lbAccount.font = PRFont.sideBarMenuFont
        lbSetting.font = PRFont.sideBarMenuFont
        lbTermsAndConditions.font = PRFont.sideBarMenuFont
        lbPrivacy.font = PRFont.sideBarMenuFont
        lbLogout.font = PRFont.sideBarMenuFont
    }

}

//MARK: Button Action
extension PRSideMenuVC {
    @IBAction func editProfileTapped() {
    }
    
    @IBAction func settingTapped() {
        
    }
    
    @IBAction func termsAndConditionsTapped() {
        
    }
    
    @IBAction func privacyTapped() {
        
    }
    
    @IBAction func logoutTapped() {
        KeychainManager.shared.deleteAllSavedData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.goToLogin()
    }
}
















