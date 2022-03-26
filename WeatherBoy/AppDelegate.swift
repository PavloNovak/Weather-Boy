//
//  AppDelegate.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureWindow()

        return true
    }
}

// MARK: - Private methods

extension AppDelegate {

    private func configureWindow() {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let viewController = ViewController()

        window?.rootViewController = viewController
    }
}

