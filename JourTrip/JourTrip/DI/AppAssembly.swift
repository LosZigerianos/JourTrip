//
//  AppAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

final class AppAssembly {
    private(set) lazy var initialAssembly: InitialAssembly = InitialAssembly(loginAssembly: loginAssembly,
                                                                             signUpAssembly: signUpAssembly)
    private lazy var loginAssembly: LoginAssembly = LoginAssembly(navigationController: navigationController,
                                                                  loginService: serviceProxy)
    private lazy var signUpAssembly: SignUpAssembly = SignUpAssembly(navigationController: navigationController)
    private lazy var serviceProxy: ServiceProxy = ServiceProxy()

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
