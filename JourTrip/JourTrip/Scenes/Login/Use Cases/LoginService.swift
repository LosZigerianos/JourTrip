//
//  LoginService.swift
//  JourTrip
//
//  Created by Adrián Silva on 11/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift

typealias Credentials = (email: String, password: String)

protocol LoginServiceType {
    func login(with credentials: Credentials,
               completion: @escaping (_ response: UserLogin?, _ error: Error?) -> Void)
    func login(with credentials: Credentials) -> Single<Void>
}
