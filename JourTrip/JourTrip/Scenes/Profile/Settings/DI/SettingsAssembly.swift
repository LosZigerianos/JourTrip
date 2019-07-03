//
//  SettingsAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class SettingsAssembly {
    
    private let repository: SettingsService
    
    init(repository: SettingsService) {
        self.repository = repository
    }
    
    func viewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        viewController.putUserData = putUserData()

        return viewController
    }
    
    func putUserData() -> PutUserDataProtocol {
        return PutUserData(repository: repository)
    }
}
