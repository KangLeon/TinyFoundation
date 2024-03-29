//
//  AppDelegate.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/2.
//

import UIKit
import Defaults

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func keyWindows() -> UIWindow? {
        var window: UIWindow? = nil
        
        if #available(iOS 13.0, *) {
            for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    window = windowScene.windows.first
                    break
                }
            }
            
            return window
        }else{
            return UIApplication.shared.keyWindow
        }
    }
//
//    func exchangeRootViewController() {
//        let fundCodeArray = Defaults[.fundCodeArray]
//        if fundCodeArray.count > 0 {
//            //show SplitViewController
//
//        }else {
//            //show NavigationViewController
//
//        }
//    }
}
