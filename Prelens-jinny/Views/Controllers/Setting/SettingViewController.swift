//
//  SettingViewController.swift
//  Prelens-jinny
//
//  Created by vinova on 3/17/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingViewController: BaseViewController {

    @IBOutlet weak var vDaysToRemind: UIView!
    @IBOutlet weak var vPushNotiSwitch: PRSwitch!
    @IBOutlet weak var vStoreDiscountSwitch: PRSwitch!
    @IBOutlet weak var vVoucherNotiSwitch: PRSwitch!
    @IBOutlet weak var lbVersion: UILabel!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vPushNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            if value {
                LocalNotification.registerForLocalNotification(on: UIApplication.shared)
                self.vVoucherNotiSwitch.btnAction.isEnabled = true
                self.vStoreDiscountSwitch.btnAction.isEnabled = true
                print(value)
            } else {
                if self.vVoucherNotiSwitch.isCheck.value {
                    self.vVoucherNotiSwitch.btnActionTapped()
                }
                if self.vStoreDiscountSwitch.isCheck.value {
                    self.vStoreDiscountSwitch.btnActionTapped()
                }
                self.vVoucherNotiSwitch.btnAction.isEnabled = false
                self.vStoreDiscountSwitch.btnAction.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        vVoucherNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            if value {
                LocalNotification.dispatchlocalNotification(with: "Notification Title for iOS10+", body: "This is the notification body, works on all versions")
                //TODO
            } else {
                //TODO
            }
        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
        setVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Setting", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    
    func setVersion() {
        let version     = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
        let build       = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "0"
        lbVersion.text  = "Jinny v\(version) build\(build)"
    }

    @IBAction func btnChangePasswordTapped(_ sender: Any) {
        let changePasswordVC = PRChangePassWordViewController.initControllerFromNib()
        self.push(controller: changePasswordVC)
    }
}
