//
//  LocalNotification.swift
//  Prelens-jinny
//
//  Created by vinova on 3/27/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import UserNotifications

class LocalNotification: NSObject, UNUserNotificationCenterDelegate {
    
    class func registerForLocalNotification(on application:UIApplication) {
        if (UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
            let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            notificationCategory.identifier = "NOTIFICATION_CATEGORY"
            //registerting for the notification.
            application.registerUserNotificationSettings(UIUserNotificationSettings(types:[.sound, .alert, .badge], categories: nil))
        }
    }

class func dispatchlocalNotification(with title: String, body: String, userInfo: [AnyHashable: Any]? = nil,day:Date, dayBeforeExprise:Int) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy z"
//        dateFormatter.timeZone = .current
//        dateFormatter.locale   =  Locale(identifier: "en_SG")
        guard let dayBefore = Calendar.current.date(byAdding: .day, value: -dayBeforeExprise, to: day) else {return}
        print(dayBefore)
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.categoryIdentifier = "Fechou"
            if let info = userInfo {
                content.userInfo = info
            }
            content.sound = UNNotificationSound.default()
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.year  = calendar.component(.year, from: dayBefore)
            dateComponents.month = calendar.component(.month, from: dayBefore)
            dateComponents.day  = calendar.component(.day, from: dayBefore)
            dateComponents.hour = 14
            dateComponents.minute = 14
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
            
        } else {
            
            let notification = UILocalNotification()
            notification.fireDate = dayBefore
            notification.alertTitle = title
            notification.alertBody = body
            if let info = userInfo {
                notification.userInfo = info
            }
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
            
        }
    }
    
    class func removeLocalNotification(_ item: Promotion) {
        guard let scheduledLocalNotifications = UIApplication.shared.scheduledLocalNotifications else { return }
        for notification in scheduledLocalNotifications {
            if notification.userInfo!["id"] as? Int == item.merchant?.id {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }
    }
    
    class func setupSettingStatus(){
        let notificationType = UIApplication.shared.currentUserNotificationSettings?.types
        if notificationType?.rawValue != 0 {
            KeychainManager.shared.saveBool(value: true, forkey: KeychainItem.pushNotificationStatus)
            KeychainManager.shared.saveBool(value: true, forkey: KeychainItem.voucherExprireStatus)
            KeychainManager.shared.saveBool(value: true, forkey: KeychainItem.storeDiscountStatus)
        } else {
            KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.pushNotificationStatus)
            KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.voucherExprireStatus)
            KeychainManager.shared.saveBool(value: false, forkey: KeychainItem.storeDiscountStatus)
        }
    }
}
