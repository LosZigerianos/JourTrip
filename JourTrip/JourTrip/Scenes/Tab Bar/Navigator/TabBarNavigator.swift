//
//  TabBarNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 22/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol TabBarNavigatorProtocol {
	func navigateToTabBar()
}

struct TabBarNavigator: TabBarNavigatorProtocol {

	let tabBarViewControllerProvider: TabBarViewControllerProvider
	let navigationController: UINavigationController

	init(navigationController: UINavigationController,
		tabBarViewControllerProvider: TabBarViewControllerProvider) {
		self.tabBarViewControllerProvider = tabBarViewControllerProvider
		self.navigationController = navigationController
	}

	func navigateToTabBar() {
		let tabBarController = tabBarViewControllerProvider.viewController()
		navigationController.viewControllers = [tabBarController]
	}
}
