//
//  SignUpNavigator.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class SignUpNavigator {

    private let signUpViewControllerProvider: SignUpViewControllerProvider
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController,
         signUpViewControllerProvider: SignUpViewControllerProvider) {
        self.navigationController = navigationController
        self.signUpViewControllerProvider = signUpViewControllerProvider
    }

    func navigateToSignUp() {
        let signUpViewController = signUpViewControllerProvider.signUpViewController()
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}
