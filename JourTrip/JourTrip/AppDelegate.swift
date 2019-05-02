//
//  AppDelegate.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let serviceProxy = ServiceProxy()
        let loginViewModel = LoginViewModel(loginService: serviceProxy)
        let loginViewController = LoginViewController(viewModel: loginViewModel)

        window?.rootViewController = loginViewController

        return true
    }
}

