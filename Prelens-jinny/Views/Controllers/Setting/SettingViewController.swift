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
import UserNotifications

class SettingViewController: BaseViewController {

    @IBOutlet weak var lbDaysToRemind: UILabel!
    @IBOutlet weak var lbNumberDay: UILabel!
    @IBOutlet weak var vDaysToRemind: UIView!
    @IBOutlet weak var vPushNotiSwitch: PRSwitch!
    @IBOutlet weak var vStoreDiscountSwitch: PRSwitch!
    @IBOutlet weak var vVoucherNotiSwitch: PRSwitch!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var btnDayToRemind: UIButton!
    var listDay = [1,2,3,4,5,6,7]
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        vVoucherNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            if value {
                self.btnDayToRemind.isEnabled = true
                self.lbNumberDay.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.lbDaysToRemind.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                LocalNotification.dispatchlocalNotification(with: "aaaa", body: "Test",day:"29/03/2018",dayBeforeExprise: 0)
                //TODO
            } else {
                self.lbDaysToRemind.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
                self.lbNumberDay.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
                self.btnDayToRemind.isEnabled = false
                 UIApplication.shared.cancelAllLocalNotifications()
                //TODO
            }
        }).disposed(by: disposeBag)
        
        btnDayToRemind.rx.tap
            .throttle(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                let choose = SelectDataPopUpView()
                choose.delegate = self
                choose.showPopUp()
            }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
        setVersion()
    }
    
    func setupView() {
        if let _pushNotificationStatus = KeychainManager.shared.getBool(key: KeychainItem.pushNotificationStatus) {
            vPushNotiSwitch.isCheck.value = _pushNotificationStatus
            print(vPushNotiSwitch.isCheck.value)
        } else {
            vPushNotiSwitch.isCheck.value = false
        }
        
        if let _voucherExprireStatus = KeychainManager.shared.getBool(key: KeychainItem.voucherExprireStatus) {
            vVoucherNotiSwitch.isCheck.value = _voucherExprireStatus
        } else {
             vVoucherNotiSwitch.isCheck.value = false
        }
        
        if let _storeDiscountStatus = KeychainManager.shared.getBool(key: KeychainItem.storeDiscountStatus) {
            vStoreDiscountSwitch.isCheck.value = _storeDiscountStatus
        } else {
            vStoreDiscountSwitch.isCheck.value = false
        }
        bindData()
    }
    
    func bindData() {
        vPushNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            if value {
                LocalNotification.registerForLocalNotification(on: UIApplication.shared)
                self.vVoucherNotiSwitch.btnAction.isEnabled = true
                self.vStoreDiscountSwitch.btnAction.isEnabled = true
            } else {
                if self.vVoucherNotiSwitch.isCheck.value {
                    self.vVoucherNotiSwitch.btnActionTapped()
                    KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.voucherExprireStatus)
                }
                if self.vStoreDiscountSwitch.isCheck.value {
                    self.vStoreDiscountSwitch.btnActionTapped()
                    KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.storeDiscountStatus)
                }
                self.vVoucherNotiSwitch.btnAction.isEnabled = false
                self.vStoreDiscountSwitch.btnAction.isEnabled = false
                UIApplication.shared.cancelAllLocalNotifications()
            }
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.pushNotificationStatus)
        }).disposed(by: disposeBag)
        
        vVoucherNotiSwitch.isCheck.asObservable().subscribe(onNext: { value in
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.voucherExprireStatus)
        }).disposed(by: disposeBag)
        
        vStoreDiscountSwitch.isCheck.asObservable().subscribe(onNext: { value in
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.storeDiscountStatus)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Setting", textColor: .black, backgroundColor: .white)
        addBackButton()
        setupView()
      
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

extension SettingViewController:SelectDataPopUpViewDelegate {
    
    func numberOfRows() -> Int {
        return 7
    }
    
    func titleForRow(index:Int) -> String {
        let title = String(listDay[index])
        return title
    }
    func didSelectRow(index:Int) {
       lbNumberDay.text = ("\(listDay[index]) days")
    }
}
