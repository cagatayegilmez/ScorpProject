//
//  AppDelegate.swift
//  ScorpProject
//
//  Created by Çağatay Eğilmez on 20.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        redirectHome()
        return true
    }
    
    func redirectHome() {
        let home: UIViewController = PeopleListBuilder.build()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = home
        window.makeKeyAndVisible()
    }
}

