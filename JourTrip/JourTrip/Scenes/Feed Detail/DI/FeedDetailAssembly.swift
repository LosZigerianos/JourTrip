//
//  FeedDetailAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 16/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class FeedDetailAssembly {
	let navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func navigator() -> FeedDetailNavigatorProtocol {
		return FeedDetailNavigator(navigationController: navigationController,
								   feedDetailViewControllerProvider: self)
	}
}

extension FeedDetailAssembly: FeedDetailViewControllerProvider {
	func viewController(with model: Comment) -> FeedDetailViewController {
		return FeedDetailViewController(comment: model)
	}
}
