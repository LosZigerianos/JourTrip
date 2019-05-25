//
//  LoginAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class LoginAssembly {

    private let loginService: LoginServiceType
    private let navigationController: UINavigationController
	private let tabBarAssembly: TabBarAssembly

    init(navigationController: UINavigationController,
         loginService: LoginServiceType,
		 tabBarAssembly: TabBarAssembly) {
        self.navigationController = navigationController
        self.loginService = loginService
		self.tabBarAssembly = tabBarAssembly
    }

    func viewModel() -> LoginViewModel {
        return LoginViewModel(loginService: loginService,
                              loginValidator: validator())
    }

    func validator() -> LoginValidator {
        return LoginValidator()
    }

    func navigator() -> LoginNavigator {
        return LoginNavigator(navigationController: navigationController,
                              loginViewControllerProvider: self)
    }
}

extension LoginAssembly: LoginViewControllerProvider {
    func loginViewController() -> LoginViewController {
        return LoginViewController(viewModel: viewModel(),
								   navigator: tabBarAssembly.navigator())
    }
}
