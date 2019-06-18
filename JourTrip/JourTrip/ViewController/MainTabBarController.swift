//
//  MainTabBarController.swift
//  JourTrip
//
//  Created by Alexandre on 19/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    var userID = ""
    
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

extension MainTabBarController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.isKind(of: SearchViewController.self) {
            let searchViewController = viewController  as! SearchViewController
            searchViewController.userID = userID
        }
 
        return true
    }
}
