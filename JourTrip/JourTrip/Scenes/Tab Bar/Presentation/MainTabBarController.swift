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
    
    var userID = "5ce9c088996e2d101513ad1d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        let feedViewController = SearchViewController()
        feedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let profileViewController = SearchViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let tabBarList = [feedViewController, searchViewController, profileViewController]
        viewControllers = tabBarList
    }
}

extension MainTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if viewController.isKind(of: SearchViewController.self) {
            let searchViewController = viewController  as! SearchViewController
            searchViewController.userID = userID
        }
        return true
    }
}
