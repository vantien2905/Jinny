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
    var listDay = ["1","2","3","4","5","6","7"]
    
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkStatus()
        self.navigationController?.navigationBar.isHidden = false
        setTitle(title: "Setting", textColor: .black, backgroundColor: .white)
        addBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindData()
    }
    
    func setupView() {
        //detectAllowNotification()
        if let _lefDayToRemind = KeychainManager.shared.getString(key: KeychainItem.leftDayToRemind){
             lbNumberDay.text = _lefDayToRemind + " days"
        } else {
             lbNumberDay.text = "7 days"
            KeychainManager.shared.saveString(value: "7" , forkey: KeychainItem.leftDayToRemind)
        }
        let notificationType = UIApplication.shared.currentUserNotificationSettings?.types
        if notificationType?.rawValue != 0 {
            if let _pushNotificationStatus = KeychainManager.shared.getBool(key: KeychainItem.pushNotificationStatus),
                let _voucherExprireStatus = KeychainManager.shared.getBool(key: KeychainItem.voucherExprireStatus),
                let _storeDiscountStatus = KeychainManager.shared.getBool(key: KeychainItem.storeDiscountStatus) {
            
                vPushNotiSwitch.isCheck.value       = _pushNotificationStatus
                vVoucherNotiSwitch.isCheck.value    = _voucherExprireStatus
                vStoreDiscountSwitch.isCheck.value  = _storeDiscountStatus
            } else {
                vPushNotiSwitch.isCheck.value       = true
                vVoucherNotiSwitch.isCheck.value    = true
                vStoreDiscountSwitch.isCheck.value  = true
            }
        } else {
            vPushNotiSwitch.isCheck.value       = false
            vVoucherNotiSwitch.isCheck.value    = false
            vStoreDiscountSwitch.isCheck.value  = false
            lbNumberDay.text                    = "7 days"
        }
    }
    
    func bindData() {
        vPushNotiSwitch.isCheck.asObservable().subscribe(onNext: { [weak self] (value) in
            guard let strongSelf = self else {return}
            if value {
                LocalNotification.registerForLocalNotification(on: UIApplication.shared)
                strongSelf.vVoucherNotiSwitch.btnAction.isEnabled = true
                strongSelf.vStoreDiscountSwitch.btnAction.isEnabled = true
            } else {
                if strongSelf.vVoucherNotiSwitch.isCheck.value {
                    strongSelf.vVoucherNotiSwitch.btnActionTapped()
                    KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.voucherExprireStatus)
                }
                if strongSelf.vStoreDiscountSwitch.isCheck.value {
                    strongSelf.vStoreDiscountSwitch.btnActionTapped()
                    KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.storeDiscountStatus)
                }
                //strongSelf.vVoucherNotiSwitch.btnAction.isEnabled = false
                //strongSelf.vStoreDiscountSwitch.btnAction.isEnabled = false
                UIApplication.shared.cancelAllLocalNotifications()
            }
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.pushNotificationStatus)
        }).disposed(by: disposeBag)
        
        vVoucherNotiSwitch.isCheck.asObservable().subscribe(onNext: { [weak self ]value in
            guard let strongSelf = self else {return}
            if value {
                strongSelf.btnDayToRemind.isEnabled = true
                strongSelf.lbNumberDay.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                strongSelf.lbDaysToRemind.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
               // LocalNotification.dispatchlocalNotification(with: "aaaa", body: "Test",day:"03/04/2018 +0000",dayBeforeExprise: 0)
            } else {
                strongSelf.lbDaysToRemind.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
                strongSelf.lbNumberDay.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
                strongSelf.btnDayToRemind.isEnabled = false
                UIApplication.shared.cancelAllLocalNotifications()
            }
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.voucherExprireStatus)
        }).disposed(by: disposeBag)
        
        vStoreDiscountSwitch.isCheck.asObservable().subscribe(onNext: { value in
            KeychainManager.shared.saveBool(value: value, forkey: KeychainItem.storeDiscountStatus)
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
        let title = listDay[index]
        return title
    }
    
    func didSelectRow(index:Int) {
        if Int(listDay[index]) == 1 {
            lbNumberDay.text = listDay[index] + " day"
        } else {
            lbNumberDay.text = listDay[index] + " days"
        }
        print(listDay[index])
        KeychainManager.shared.saveString(value: listDay[index] , forkey: KeychainItem.leftDayToRemind)
    }
}
