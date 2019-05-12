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
    private let loginViewControllerProvider: LoginViewControllerProvider

    init(navigationController: UINavigationController,
         loginViewControllerProvider: LoginViewControllerProvider) {
        self.navigationController = navigationController
        self.loginViewControllerProvider = loginViewControllerProvider
    }

    func navigateToLogin() {
        let loginViewController = loginViewControllerProvider.loginViewController()
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
