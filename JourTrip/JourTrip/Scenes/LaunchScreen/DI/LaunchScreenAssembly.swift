//
//  LaunchScreenAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class LaunchScreenAssembly {

	private let initialAssembly: InitialAssembly
	private let tabBarAssembly: TabBarAssembly
	private let loginService: LoginServiceType

	init(initialAssembly: InitialAssembly,
		 tabBarAssembly: TabBarAssembly,
		 loginService: LoginServiceType) {
		self.initialAssembly = initialAssembly
		self.loginService = loginService
		self.tabBarAssembly = tabBarAssembly
	}

	func viewController() -> LaunchScreenViewController {
		return LaunchScreenViewController(loginService: loginService,
										  launchScreenNavigator: navigator())
	}

	func navigator() -> LaunchScreenNavigatorProtocol {
		return LaunchScreenNavigator(tabBarNavigator: tabBarAssembly.navigator(),
									 initialNavigator: initialAssembly.navigator())
	}
}
