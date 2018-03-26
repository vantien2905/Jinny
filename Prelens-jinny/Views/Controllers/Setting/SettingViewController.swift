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
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vPushNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            if value {
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
                //TODO
            } else {
                //TODO
            }
        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Setting", textColor: .black, backgroundColor: .white)
        addBackButton()
    }

    @IBAction func btnChangePasswordTapped(_ sender: Any) {
        let changePasswordVC = PRChangePassWordViewController.initControllerFromNib()
        self.push(controller: changePasswordVC)
    }
}
