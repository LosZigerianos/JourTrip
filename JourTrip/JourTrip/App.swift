//
//  App.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class App {
    private let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private lazy var rootViewController = UINavigationController()

    func setupRootViewController() {
        let loginNavigator = LoginNavigator(navigationController: rootViewController)
        let initialViewModel = InitialViewModel(loginNavigator: loginNavigator)
        let initialViewController = InitialViewController(viewModel: initialViewModel)
        rootViewController.viewControllers = [initialViewController]
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}