//
//  InitialAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class InitialAssembly {

    private let loginAssembly: LoginAssembly
    private let signUpAssembly: SignUpAssembly
	private let navigationController: UINavigationController

    init(navigationController: UINavigationController,
		 loginAssembly: LoginAssembly,
         signUpAssembly: SignUpAssembly) {
        self.loginAssembly = loginAssembly
        self.signUpAssembly = signUpAssembly
		self.navigationController = navigationController
    }

	func navigator() -> InitialNavigatorProtocol {
		return InitialNavigator(navigationController: navigationController,
								initialViewControllerProvider: self)
	}

    private func viewModel() -> InitialViewModel {
        return InitialViewModel(loginNavigator: loginAssembly.navigator(),
                                signUpNavigator: signUpAssembly.navigator())
    }
}

extension InitialAssembly: InitialViewControllerProvider {
	func viewController() -> InitialViewController {
		return InitialViewController(viewModel: viewModel())
	}
}
