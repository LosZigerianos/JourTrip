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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigator() -> SignUpNavigator {
        return SignUpNavigator(navigationController: navigationController,
                               signUpViewControllerProvider: self)
    }
}

extension SignUpAssembly: SignUpViewControllerProvider {
    func signUpViewController() -> SignUpViewController {
        return SignUpViewController()
    }
}
