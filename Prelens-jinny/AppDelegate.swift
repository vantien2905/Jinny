//
//  AppDelegate.swift
//  Prelens-jinny
//
//  Created by Lamp on 5/3/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var badgeNumbers = 0
    var window: UIWindow?
    
    var tabbarController: HomeViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.applicationIconBadgeNumber = 0
        //remote notification
        
        configureFirebase(on: application)
        
        Fabric.with([Crashlytics.self])
        handleFlow(application: application)
        LocalNotification.registerForLocalNotification(on: application)
        return true
    }

    func handleFlow(application:UIApplication ) {
        UITabBar.appearance().tintColor = UIColor.red
        let defaults = UserDefaults.standard
         if defaults.string(forKey: KeychainItem.isFirstRunning.rawValue) != nil {
            if KeychainManager.shared.getToken() != nil {
                goToMainApp()
            } else {
                goToLogin()
            }
         } else {
            KeychainManager.shared.deleteAllSavedData()
            goToLogin()
        }
    }

    func goToLogin() {
        let vc  = UINavigationController(rootViewController: PRLoginViewController())
        window?.rootViewController = vc
    }

    func goToMainApp() {
        tabbarController = HomeViewController()
        guard let tabbarVC = tabbarController else { return }
        let vc  = UINavigationController(rootViewController: tabbarVC)
        window?.rootViewController = vc

        //        apiNotification.asObservable().subscribe(onNext: { [weak self] unreadNotification in
        //            guard let _unreadNotification = unreadNotification else { return }
        //            self?.handleUnread(notification: _unreadNotification)
        //        }).disposed(by: disposeBag)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        switch application.applicationState {
        case .active:
            print("case App is active")
        case .background:
            print("case App is in background")
        case .inactive:
            print("case App is inactive")
        }
    }
    
    private func backupNotification(on application: UIApplication) {
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
    }
}
extension AppDelegate:UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        guard var voucherID =  notification.request.content.userInfo["id"] as? String else {return}
        let voucherID = "70b43fc8-9e0d-4e53-af0e-fe2fe5a1f203" // Under testing
        print(voucherID)
        let route = Route(tabbar: .vouchers)
        Navigator.shared.handle(route: route, id: voucherID)
        
        completionHandler(.alert)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        guard var voucherID =  userInfo["id"] as? String else { return }
        print(voucherID)
        let route = Route(tabbar: .vouchers)
        Navigator.shared.handle(route: route, id: voucherID)
        completionHandler(.newData)
        
    }
}

// MARK: Notification
extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        Messaging.messaging().apnsToken = deviceToken // Disabled swizzling in plist.info
        let fcmToken = Messaging.messaging().fcmToken ?? ""
        KeychainManager.shared.saveString(value: fcmToken, forkey: KeychainItem.fcmToken)
        
        print("=> FCM token: \(Messaging.messaging().fcmToken ?? "")")
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: Firebase messaging
extension AppDelegate: MessagingDelegate {
    func configureFirebase(on application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = true
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                                    completionHandler: {_, _ in })
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        let googleServiceFile = "GoogleService-Info"
        
        let filePath = Bundle.main.path(forResource: googleServiceFile, ofType: "plist")!
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            print("There are some problems with GoogleService-Info file")
            return
        }
        
        FirebaseApp.configure(options: options)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("=> didRefreshRegistrationToken: \(fcmToken)")
        KeychainManager.shared.saveString(value: fcmToken, forkey: KeychainItem.fcmToken)
    }
}
