//
//  AppDelegate.swift
//  GithubDM
//
//  Created by Satish on 09/10/19.
//  Copyright © 2019 Satish Babariya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: UsersViewController())
        window?.makeKeyAndVisible()

        return true
    }
}
