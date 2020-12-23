//
//  LoginValidatorTests.swift
//  JourTripTests
//
//  Created by Adrián Silva on 11/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import JourTrip

class LoginValidatorTests: XCTestCase {

    var loginValidator: LoginValidatorType!

    override func setUp() {
        super.setUp()

        loginValidator = LoginValidator()
    }

    func test_GivenAValidEmail_WhenValidated_ThenShouldReturnAValidValue() {
        let validEmail = "somevalid@email.com"

        let loginResult = loginValidator.validate(email: validEmail)

        XCTAssert(loginResult)
    }

    func test_GivenAnInvalidEmail_WhenValidated_ThenShoulReturnAnInvalidValue() {
        let invalidEmail = "so"

        let loginResult = loginValidator.validate(email: invalidEmail)

        XCTAssertFalse(loginResult)
    }

    func test_GivenAValidPassword_WhenValidated_ThenShouldReturnAValidValue() {
        let validPassword = "somepassword"

        let loginResult = loginValidator.validate(password: validPassword)

        XCTAssert(loginResult)
    }

    func test_GivenAnInvalidPassword_WhenValidated_ThenShouldReturnAnInvalidValue() {
        let invalidPassword = "so"

        let loginResult = loginValidator.validate(password: invalidPassword)

        XCTAssertFalse(loginResult)
    }
    
    func test_DecodeLoginResponse() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "login_response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let login = try decoder.decode(UserLogin.self, from: data)
            XCTAssertNotNil(login)
        } catch {
            XCTFail()
        }
    }
}
