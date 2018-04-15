//
//  PromotionViewModel.swift
//  Prelens-jinny
//
//  Created by vinova on 3/20/18.
//  Copyright © 2018 Lamp. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

protocol AllPromotionViewModelProtocol {
    var textSearch: Variable<String?> {get set}
    var listAllPromotion: Variable<[Promotion]?> {get}
    var listSearchVoucher:  Variable<[Promotion]?> {get}
    var isLatest: Variable<Bool> {get set}
    func getListAllPromotion(order: String)
    func refresh()
}

class AllPromotionViewModel: AllPromotionViewModelProtocol {
    var isLatest: Variable<Bool>
    var textSearch: Variable<String?> = Variable<String?>(nil)
    var listSearchVoucher: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listAllPromotion: Variable<[Promotion]?> = Variable<[Promotion]?>(nil)
    var listTemp = [Promotion]()
    let disposeBag = DisposeBag()
    
    init() {
        isLatest = Variable<Bool>(true)
        textSearch.asObservable().subscribe(onNext: {[weak self] (textSearch) in
            let listVoucher = self?.listSearchVoucher.value?.filter { (promotion) -> Bool in
                guard let _textSearch = textSearch else { return true }
                if _textSearch == "" {
                    return true
                } else {
                    if let _merchant = promotion.merchant, let _name = _merchant.name {
                        return _name.containsIgnoringCase(_textSearch)
                    }
                    return false
                }
            }
            if let _list = listVoucher {
                self?.listTemp = _list
            }
            
            self?.listAllPromotion.value = self?.listTemp
        }).disposed(by: disposeBag)
        sortAllPromotion()
    }
    
    func getListAllPromotion(order:String) {
        let defaults = UserDefaults.standard
        Provider.shared.promotionService.getListAllPromotion(order: order)
            //.showProgressIndicator()
            .subscribe(onNext: { [weak self] (listPromotion) in
                guard let strongSelf = self else { return }

                var listNew = [Promotion]()
                var listOld = [Promotion]()
                
                for element in listPromotion {
                    if element.isReaded == false {
                        listNew.append(element)
                    } else {
                        listOld.append(element)
                    }
                }
               
                strongSelf.listAllPromotion.value = listNew + listOld
                strongSelf.listSearchVoucher.value = listNew + listOld
                
                // MARK: Setup notification
                UIApplication.shared.cancelAllLocalNotifications()
                strongSelf.setupNotification(listData: listPromotion)
                defaults.set(listNew.count, forKey: KeychainItem.badgeNumber.rawValue)
                NotificationCenter.default.post(name: Notification.Name(rawValue: ConstantNotification.updateBadgeVoucherTabbar), object: nil)
            }).disposed(by: disposeBag)
    }
    
    func sortAllPromotion() {
        isLatest.asObservable().subscribe(onNext: {[weak self] (isLatest) in
            guard let strongSelf = self else { return }
            if isLatest {
                strongSelf.getListAllPromotion(order: ContantVoucher.sortDescending)
            } else {
                strongSelf.getListAllPromotion(order: ContantVoucher.sortAscending)
            }
        }).disposed(by: disposeBag)
    }
    func refresh() {
        isLatest.value = true
        getListAllPromotion(order: ContantVoucher.sortDescending)
    }
    
    func setupNotification(listData: [Promotion]) {
        guard let _leftDay = KeychainManager.shared.getString(key: KeychainItem.leftDayToRemind) else {return}
        guard let _voucherNotiStatus = KeychainManager.shared.getBool(key: KeychainItem.voucherExprireStatus) else {return}
        if _voucherNotiStatus {
            if listData.count != 0 {
                for item in listData {
                    guard let _name = item.merchant?.name, let _expireDate = item.expiresAt else { return  }
                    LocalNotification.dispatchlocalNotification(with: _name, body: "The vouchers will expire after \(_leftDay) days", userInfo: ["id" : item.id ?? ""], day: _expireDate, dayBeforeExprise: Int(_leftDay)!)
                }
            }
        }
    }
}
