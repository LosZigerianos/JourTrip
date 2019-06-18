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
	private lazy var rootViewController: UINavigationController = {
		let navigationController = UINavigationController()
		navigationController.navigationBar.isHidden = true
		return navigationController
	}()
    private lazy var appAssembly = AppAssembly(navigationController: rootViewController)

    func setupRootViewController() {
        let launchScreenViewController = appAssembly.launchScreenAssembly.viewController()
        rootViewController.viewControllers = [launchScreenViewController]
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
