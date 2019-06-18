//
//  AddCommentAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 18/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class AddCommentAssembly {
	let navigationController: UINavigationController
	let webService: WebService

	init(navigationController: UINavigationController,
		 webService: WebService) {
		self.navigationController = navigationController
		self.webService = webService
	}

	func addComment() -> AddReviewProtocol {
		return AddReview(repository: webService)
	}
}

extension AddCommentAssembly: AddCommentViewControllerProvider {
	func viewController(with comment: Comment) -> AddCommentViewController {
		return AddCommentViewController(addComment: addComment(),
										comment: comment)
	}
}
