//
//  MainTabBarController.swift
//  JourTrip
//
//  Created by Alexandre on 19/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol TabBarViewControllerProvider: class {
	func viewController() -> MainTabBarController
}

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    // FIXME
    private func configureTabBar() {
        let feedViewController = SignUpViewController()
        feedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let profileViewController = SignUpViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let tabBarList = [feedViewController, searchViewController, profileViewController]
        viewControllers = tabBarList
    }
}
