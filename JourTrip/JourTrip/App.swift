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
    private lazy var appAssembly = AppAssembly(navigationController: rootViewController)

    func setupRootViewController() {
        let initialViewController = appAssembly.initialAssembly.initialViewController()
        rootViewController.viewControllers = [initialViewController]
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    // FIXME: another way to load the main tabbar
    func loadTabBarController() {
        let mainTabBar = MainTabBarController()
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
            self.rootViewController.navigationController?.navigationBar.backgroundColor = UIColor.clear
            self.rootViewController.navigationController?.isNavigationBarHidden = true
            self.rootViewController.navigationController?.viewControllers = [mainTabBar]
            self.window.rootViewController = self.rootViewController
            self.window.makeKeyAndVisible()
        }, completion: nil)
        
    }
}
