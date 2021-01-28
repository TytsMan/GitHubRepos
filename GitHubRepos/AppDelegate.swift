//
//  AppDelegate.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let viewController = SearchingReposistoriesController()
        viewController.networkService = NetworkService()
        let navigationController = UINavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
