//
//  InitialNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol InitialNavigatorProtocol {
	func navigateToInitialView()
}

struct InitialNavigator: InitialNavigatorProtocol {

	private let navigationController: UINavigationController
	private let initialViewControllerProvider: InitialViewControllerProvider

	init(navigationController: UINavigationController,
		 initialViewControllerProvider: InitialViewControllerProvider) {
		self.navigationController = navigationController
		self.initialViewControllerProvider = initialViewControllerProvider
	}

	func navigateToInitialView() {
		let viewController = initialViewControllerProvider.viewController()
		navigationController.pushViewController(viewController, animated: false)
	}

}
