//
//  AppDelegate.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        initThemeApp()
        
        if UserDataManager.sharedInstance.currentUser != nil {
            let vcId = "TabBarId"
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let userInfoViewController = storyboard.instantiateViewController(withIdentifier: vcId)
            
            window?.makeKeyAndVisible()
            window?.rootViewController = userInfoViewController
        }
        
        self.setupUserNotification(application: application, launchOptions: launchOptions)
        return true
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
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        self.takeActionWithNotification()
    }
        
    func initThemeApp() {
        UINavigationBar.appearance().tintColor = UIColor.gray
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes =
            [NSForegroundColorAttributeName: AppConfig.Colors.mainColorGreen,
             NSFontAttributeName : UIFont.boldSystemFont(ofSize: 20)]
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -1000), for:UIBarMetrics.default)
        
        UITabBar.appearance().tintColor = AppConfig.Colors.mainColorGreen
    }
    

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.takeActionWithNotification()
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle the notification
    }
    
    func takeActionWithNotification() {
        guard let localNotification = UIApplication.shared.scheduledLocalNotifications?.first else {
            return
        }
        let notificationMessage = localNotification.userInfo!["Hello"] as! String
        let userName = UserDataManager.sharedInstance.currentUser?.username ?? ""
        let alertController = UIAlertController(title: "Hello \(userName)", message: notificationMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    func setupUserNotification(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // Mark: Register local notification
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
        // Mark: OneSignal
        OneSignal.initWithLaunchOptions(launchOptions, appId: "710cb97e-fdc6-4280-8ed5-9e60057acbf0")
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {
                (granted, error) in
                if (granted) {
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    //Do stuff if unsuccessful...
                }
            })
        } else { //If user is not on iOS 10 use the old methods we've been using
            let notificationSettings = UIUserNotificationSettings(
                types: [UIUserNotificationType.badge, UIUserNotificationType.sound, UIUserNotificationType.alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
            
        }
    }
}
