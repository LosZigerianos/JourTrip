//
//  TabBarAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 22/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class TabBarAssembly {

	let navigationController: UINavigationController
    let homeAssembly: FeedAssembly
	let searchAssembly: SearchAssembly
    let profileAssembly: ProfileAssembly

	init(navigationController: UINavigationController,
		 searchAssembly: SearchAssembly,
         profileAssembly: ProfileAssembly,
         feedAssembly: FeedAssembly) {
		self.navigationController = navigationController
        self.homeAssembly = feedAssembly
		self.searchAssembly = searchAssembly
        self.profileAssembly = profileAssembly
	}

    func navigator() -> TabBarNavigator {
		return TabBarNavigator(navigationController: navigationController,
							   tabBarViewControllerProvider: self)
	}

}

extension TabBarAssembly: TabBarViewControllerProvider {
	func viewController() -> MainTabBarController {
		let tabBarController = MainTabBarController()
	
		let homeViewController = homeAssembly.viewController()
		homeViewController.tabBarItem = UITabBarItem(title: "Feed", image: JourTripImages.homeTabBar(), selectedImage: JourTripImages.homeTabBar())
        let searchViewController = searchAssembly.viewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: JourTripImages.searchTabBar(), selectedImage: JourTripImages.searchTabBar())
		let profileViewController = profileAssembly.viewController()
		profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: JourTripImages.profileTabBar(), selectedImage: JourTripImages.profileTabBar())
        
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)

        
		tabBarController.viewControllers = [homeViewController, searchViewController, profileNavigationController]
		return tabBarController
	}
}
