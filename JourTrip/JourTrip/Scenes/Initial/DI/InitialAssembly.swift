//
//  InitialAssembly.swift
//  JourTrip
//
//  Created by Adrián Silva on 12/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

final class InitialAssembly {

    private let loginAssembly: LoginAssembly

    init(loginAssembly: LoginAssembly) {
        self.loginAssembly = loginAssembly
    }

    func initialViewController() -> InitialViewController {
        return InitialViewController(viewModel: viewModel())
    }

    private func viewModel() -> InitialViewModel {
        return InitialViewModel(loginNavigator: loginAssembly.loginNavigator())
    }
}
