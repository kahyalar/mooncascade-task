//
//  AppDelegate.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func generateNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: ListVC())
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = "Contacts"
        return navigationController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = generateNavigationController()
        window?.makeKeyAndVisible()
        return true
    }
}

