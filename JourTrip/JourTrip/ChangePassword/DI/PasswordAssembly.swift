//
//  PasswordAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class PasswordAssembly {
    private let repository: PasswordService
    
    init(repository: PasswordService) {
        self.repository = repository
    }
    
    func viewController() -> ChangePasswordViewController {
        let viewController = ChangePasswordViewController()
 
        viewController.getPasswordProtocol = getPasswordProtocol()
        
        return viewController
    }
    
    func getPasswordProtocol() -> GetPasswordProtocol {
        return getPasswordProtocol()
    }
}
