//
//  PRSideMenuVC.swift
//  Prelens-jinny
//
//  Created by Lamp on 14/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PRSideMenuVC: UIViewController {

    // MARK: Properties

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
    let viewModel =  SignOutViewModel()
    let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lbEmail.text = KeychainManager.shared.getString(key: .email)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        setUpView()
        
    }
    
    func bindViewModel() {
        btnLogout.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.btnSignOutTapped)
            .disposed(by: disposeBag)
    }
    
    func setUpView() {
        self.view.backgroundColor = PRColor.backgroundColor
        vAccount.backgroundColor = .yellow
        lbAccount.font = PRFont.sideBarMenuFont
        lbSetting.font = PRFont.sideBarMenuFont
        lbTermsAndConditions.font = PRFont.sideBarMenuFont
        lbPrivacy.font = PRFont.sideBarMenuFont
        lbLogout.font = PRFont.sideBarMenuFont
    }

}

// MARK: Button Action
extension PRSideMenuVC {
    @IBAction func editProfileTapped() {
        let vc = PREditProfileViewController.initControllerFromNib()
        self.push(controller: vc)
    }

    @IBAction func settingTapped() {
        let vc = SettingViewController.initControllerFromNib()
        self.push(controller: vc)
    }

    @IBAction func termsAndConditionsTapped() {
        let termVC = TermsViewController.initControllerFromNib()
        self.push(controller: termVC)
    }

    @IBAction func privacyTapped() {
        let privacyVC = PrivacyViewController.initControllerFromNib()
        self.push(controller: privacyVC)
    }
}
