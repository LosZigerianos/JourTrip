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

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension AddCommentAssembly: AddCommentViewControllerProvider {
	func viewController() -> AddCommentViewController {
		return AddCommentViewController()
	}
}
