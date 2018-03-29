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
    
    class func dispatchlocalNotification(with title: String, body: String, userInfo: [AnyHashable: Any]? = nil) {
        
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
            var dateComponents = DateComponents()
            dateComponents.hour = 09
            dateComponents.minute = 25
           // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
            
        } else {
            
            let notification = UILocalNotification()
           // notification.fireDate = date
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
}
