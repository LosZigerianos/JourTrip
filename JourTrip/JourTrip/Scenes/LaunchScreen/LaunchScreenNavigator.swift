//
//  LaunchScreenNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol LaunchScreenNavigatorProtocol {
	func nextSceneAfterLogin(_ successful: Bool)
}

struct LaunchScreenNavigator: LaunchScreenNavigatorProtocol {

	let tabBarNavigator: TabBarNavigatorProtocol
	let initialNavigator: InitialNavigatorProtocol

	init(tabBarNavigator: TabBarNavigatorProtocol,
		 initialNavigator: InitialNavigatorProtocol) {
		self.tabBarNavigator = tabBarNavigator
		self.initialNavigator = initialNavigator
	}

	func nextSceneAfterLogin(_ successful: Bool) {
		if successful {
			tabBarNavigator.navigateToTabBar()
		} else {
			initialNavigator.navigateToInitialView()
		}
	}
}
