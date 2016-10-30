//
//  AppDelegate.swift
//  scoops
//
//  Created by Edu González on 22/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        application.applicationIconBadgeNumber = 0
                
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
        // Called as part of the transition frovarhe background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    // MARK: - Notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        deviceTokenString = deviceToken.hexString()
        print("💥⛈💔deviceToken :\(deviceTokenString)")

        let hub = SBNotificationHub(connectionString: HUBLISTENACCESS, notificationHubPath: HUBNAME)

        hub?.registerNative(withDeviceToken: deviceToken, tags: nil, completion: { (error) in
            if error != nil {
                print("💥⛈💔Error registrando token: \(error)")
            } else {
                self.messageBox(title: "Registration Status", message: "Registered")
            }

        })
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

        print("💥⛈💔Error en el registro de notificaciones remotas")
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // Lo que hacemos cuando recibimos una notificacion
        // Podemos presentar una alerta si la recibimos mientras usamos la app
    }

    func messageBox(title: String, message: String) {

        print("💥⛈💔\(title)  \(message)")

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
    }
}

extension Data {
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
}

