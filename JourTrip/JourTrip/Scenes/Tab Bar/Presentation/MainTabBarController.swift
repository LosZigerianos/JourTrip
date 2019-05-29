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
    var profileBarItem = UITabBarItem()
    var searchBarItem = UITabBarItem()
    var homeBarItem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        let feedViewController = SearchViewController()
        homeBarItem = UITabBarItem(title: "Feed", image: EelpImages.homeTabBar(), selectedImage: EelpImages.homeTabBar())
        homeBarItem.tag = 0
        feedViewController.tabBarItem = homeBarItem
        
        let searchViewController = SearchViewController()
        searchBarItem = UITabBarItem(title: "Search", image: EelpImages.searchTabBar(), selectedImage: EelpImages.searchTabBar())
        searchBarItem.tag = 1
        searchViewController.tabBarItem = searchBarItem
        
        let profileViewController = SearchViewController()
        searchBarItem = UITabBarItem(title: "Profile", image: EelpImages.profileTabBar(), selectedImage: EelpImages.profileTabBar())
        searchBarItem.tag = 2
        profileViewController.tabBarItem = searchBarItem
        
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
