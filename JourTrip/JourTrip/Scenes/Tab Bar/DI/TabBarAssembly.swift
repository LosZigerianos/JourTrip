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

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func navigator() -> TabBarNavigator {
		return TabBarNavigator(navigationController: navigationController,
							   tabBarViewControllerProvider: self)
	}
	
}

extension TabBarAssembly: TabBarViewControllerProvider {
	func viewController() -> MainTabBarController {
		return MainTabBarController()
	}
}
