//
//  SignUpValidator.swift
//  JourTrip
//
//  Created by Adrián Silva on 25/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol SignUpValidatorType {
	/// Validates the email.
	///
	/// - Parameter email: The given email.
	/// - Returns: A boolean value. True when valid, false otherwise.
	func validate(email: String) -> Bool
	/// Validates the password.
	///
	/// - Parameter password: The given password.
	/// - Returns: A boolean value. True when valid, false otherwise.
	func validate(password: String) -> Bool
}

struct SignUpValidator: SignUpValidatorType {
	func validate(email: String) -> Bool {
		return email.utf8.count > 2
	}

	func validate(password: String) -> Bool {
		return password.utf8.count > 2
	}
}
