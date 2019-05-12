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

    init(navigationController: UINavigationController,
         loginService: LoginServiceType) {
        self.navigationController = navigationController
        self.loginService = loginService
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
        return LoginViewController(viewModel: viewModel())
    }
}
