//
//  RegisterService.swift
//  JourTrip
//
//  Created by Adrián Silva on 25/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterServiceType {
	func register(with credentials: Credentials,
				  completion: @escaping (_ response: UserResponse?, _ error: Error?) -> Void)
	func register(with credentials: Credentials) -> Single<Void>
}
