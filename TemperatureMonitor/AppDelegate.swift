//
//  AppDelegate.swift
//  TemperatureMonitor
//
//  Created by ayaz on 25.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let temperatureViewController = TemperatureViewController()
        window?.rootViewController = UINavigationController(rootViewController: temperatureViewController)
        window?.makeKeyAndVisible()
        
        
        return true
    }
}

