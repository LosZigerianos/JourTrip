//
//  LoginValidator.swift
//  JourTrip
//
//  Created by Adrián Silva on 11/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol LoginValidatorType {
    func validate(email: String) -> Bool
    func validate(password: String) -> Bool
}

struct LoginValidator: LoginValidatorType {
    func validate(email: String) -> Bool {
        return email.utf8.count > 2
    }

    func validate(password: String) -> Bool {
        return password.utf8.count > 2
    }
}
