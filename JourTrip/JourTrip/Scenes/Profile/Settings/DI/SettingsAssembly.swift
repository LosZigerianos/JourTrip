//
//  SettingsAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class SettingsAssembly {
    private let repository: WebService
    private let navigationController: UINavigationController
    
    
    init(webService: WebService, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = webService
    }
    
    func viewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        viewController.putUserDataProtocol = putUserData()

        return viewController
    }
    
    func putUserData() -> PutUserDataProtocol {
        return PutUserData(repository: repository)
    }
}
