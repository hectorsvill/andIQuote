//
//  AppDelegate.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Network
import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var shortcutItemToProcess: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        signAnonnamously()

        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            shortcutItemToProcess = shortcutItem
            NSLog("\(shortcutItem.type)")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutItemToProcess = shortcutItem
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let shortcutItem = shortcutItemToProcess {
            
            let localizedSubtitle = shortcutItem.localizedSubtitle!
//            let name = shortcutItem.userInfo!["Name"]
            
            let activityVC = UIActivityViewController(activityItems: [localizedSubtitle], applicationActivities: [])
            window?.rootViewController?.present(activityVC, animated: true, completion: nil)
            
            shortcutItemToProcess = nil
        }
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
}

// MARK: Helpers

extension AppDelegate {
    
    private func signAnonnamously() {
        Auth.auth().signInAnonymously { _, error in
            if let error = error {
                NSLog("Erro with signInAnonymously: \(error)")
            }
        }
    }

    private func setupNetworkMonitor() {
        // note: read docs on on cashing data
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler =  { path in
            if path.status == .satisfied {
                print("internet connection 😀")
            } else {
                print("no internet 😳")
            }
            
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
}
