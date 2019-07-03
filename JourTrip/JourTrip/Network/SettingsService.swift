//
//  SettingsService.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol SettingsService {
    func putUserData(username: String,
                          fullname: String,
                          email: String,
                          completion: @escaping (_ response: ProfileResponse?, _ error: Error?) -> Void)
}

