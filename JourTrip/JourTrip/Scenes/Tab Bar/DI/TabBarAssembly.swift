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
	let searchAssembly: SearchAssembly

	init(navigationController: UINavigationController,
		 searchAssembly: SearchAssembly) {
		self.navigationController = navigationController
		self.searchAssembly = searchAssembly
	}

	func navigator() -> TabBarNavigator {
		return TabBarNavigator(navigationController: navigationController,
							   tabBarViewControllerProvider: self)
	}
	
}

extension TabBarAssembly: TabBarViewControllerProvider {
	func viewController() -> MainTabBarController {
		let tabBarController = MainTabBarController()
		let searchViewController = searchAssembly.viewController()
		searchViewController.tabBarItem = UITabBarItem(title: "Search", image: EelpImages.searchTabBar(), selectedImage: EelpImages.searchTabBar())
		let feedViewController = UIViewController()
		feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: EelpImages.homeTabBar(), selectedImage: EelpImages.homeTabBar())
		let profileViewController = UIViewController()
		profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: EelpImages.profileTabBar(), selectedImage: EelpImages.profileTabBar())
		tabBarController.viewControllers = [feedViewController, searchViewController, profileViewController]
		return tabBarController
	}
}
