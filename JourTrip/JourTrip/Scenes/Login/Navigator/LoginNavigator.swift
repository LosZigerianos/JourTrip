//
//  LoginNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class LoginNavigator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigateToLogin() {
        let serviceProxy = ServiceProxy()
        let loginValidator = LoginValidator()
        let loginViewModel = LoginViewModel(loginService: serviceProxy,
                                            loginValidator: loginValidator)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
