//
//  AppDelegate.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-02-19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let products = [
        Product(name: "Pants", quantity: 20, price: 50.7),
        Product(name: "Shoes", quantity: 50, price: 90),
        Product(name: "Hats", quantity: 10, price: 20.5),
        Product(name: "Tshirts", quantity: 10, price: 10.6),
        Product(name: "Dresses", quantity: 24, price: 70.3),
        Product(name: "Socks", quantity: 50, price: 5.7)
    ]
    
    let productHistory: [History] = []
    


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


}

