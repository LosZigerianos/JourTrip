//
//  SignUpAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SignUpAssembly {

    private let navigationController: UINavigationController
	private let service: RegisterServiceType
	private let tabBarAssembly: TabBarAssembly

    init(navigationController: UINavigationController,
		 service: RegisterServiceType,
		 tabBarAssembly: TabBarAssembly) {
        self.navigationController = navigationController
		self.service = service
		self.tabBarAssembly = tabBarAssembly
    }

    func navigator() -> SignUpNavigator {
        return SignUpNavigator(navigationController: navigationController,
                               signUpViewControllerProvider: self)
    }

	func viewModel() -> SignUpViewModel {
		return SignUpViewModel(validator: validator(),
							   service: service)
	}

	func validator() -> SignUpValidator {
		return SignUpValidator()
	}
}

extension SignUpAssembly: SignUpViewControllerProvider {
    func signUpViewController() -> SignUpViewController {
        return SignUpViewController(viewModel: viewModel(),
									navigator: tabBarAssembly.navigator())
    }
}
