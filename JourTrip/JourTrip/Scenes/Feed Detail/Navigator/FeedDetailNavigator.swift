//
//  FeedDetailNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 16/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

protocol FeedDetailNavigatorProtocol {
	func presentDetail(with comment: Comment)
}

struct FeedDetailNavigator: FeedDetailNavigatorProtocol {
	private let navigationController: UINavigationController
	private let feedDetailViewControllerProvider: FeedDetailViewControllerProvider

	init(navigationController: UINavigationController,
		 feedDetailViewControllerProvider: FeedDetailViewControllerProvider) {
		self.navigationController = navigationController
		self.feedDetailViewControllerProvider = feedDetailViewControllerProvider
	}

	func presentDetail(with comment: Comment) {
		let viewController = feedDetailViewControllerProvider.viewController(with: comment)
		navigationController.present(viewController, animated: true)
	}
}
