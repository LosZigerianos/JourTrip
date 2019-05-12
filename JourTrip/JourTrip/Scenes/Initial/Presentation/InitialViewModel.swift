//
//  InitialViewModel.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct InitialViewModel {

    private let loginNavigator: LoginNavigator

    init(loginNavigator: LoginNavigator) {
        self.loginNavigator = loginNavigator
    }

    func loginTapped() {
        loginNavigator.navigateToLogin()
    }

    func signupTapped() {

    }

}
