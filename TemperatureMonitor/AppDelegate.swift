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
        
        let temperatureViewController = TemperatureViewController()
        window?.rootViewController = UINavigationController(rootViewController: temperatureViewController)
        
        return true
    }
}

