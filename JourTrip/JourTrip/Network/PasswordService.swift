//
//  PasswordService.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol PasswordService {
    func updatePassword(newPassword: String,
                        oldPassword: String,
                        completion: @escaping (_ response: UserSignUp?, _ error: Error?) -> Void)
}
