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

    let app = App()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        app.setupRootViewController()

        return true
    }
}

