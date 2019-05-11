//
//  LoginViewModel.swift
//  JourTrip
//
//  Created by Adrián Silva on 02/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {

    private let loginService: LoginServiceType
    private let loginValidator: LoginValidatorType

    init(loginService: LoginServiceType,
         loginValidator: LoginValidatorType) {
        self.loginService = loginService
        self.loginValidator = loginValidator
    }

    /// Transforms the ViewModel inputs into Outputs
    func transform(inputs: LoginViewModel.Inputs) -> LoginViewModel.Outputs {
        // Check if the email text is valid
        // Email is valid if it has > 2 characters
        let emailValid = inputs.emailText
            .distinctUntilChanged()
            .throttle(0.2, scheduler: MainScheduler.instance)
            .map(loginValidator.validate(email:))
            .asDriver(onErrorDriveWith: .empty())

        // Check if the password text is valid
        // Password is valid if it has > 2 characters
        let passwordValid = inputs.passwordText
            .distinctUntilChanged()
            .throttle(0.2, scheduler: MainScheduler.instance)
            .map(loginValidator.validate(password:))
            .asDriver(onErrorDriveWith: .empty())

        // Combine the results of valid operations
        // If email and password are valid, login button is enabled
        let buttonEnabled = Driver
            .combineLatest(emailValid, passwordValid) { $0 && $1 }

        // (email: EmailText, password: PasswordText)
        let credentials = Observable
            .combineLatest(inputs.emailText, inputs.passwordText)

        // When the button is tapped, we check the credentials
        // Then the login service is fired
        // If the login is successful it will throw a Void value
        // Otherwise the sequence won't emit any value
        let loginSuccessful = inputs.buttonTap
            .withLatestFrom(credentials)
            .flatMap(loginService.login(with:))
            .asDriver(onErrorDriveWith: .never())

        return Outputs(buttonEnabled: buttonEnabled, loginSuccessful: loginSuccessful)
    }
}

extension LoginViewModel {
    struct Inputs {
        /// A sequence with the email text
        let emailText: Observable<String>
        /// A sequence with the password text
        let passwordText: Observable<String>
        /// A sequence that executes a Void value when the user presses the button
        let buttonTap: Observable<Void>
    }

    struct Outputs {
        /// A sequence with true in case of enabled and false otherwise
        let buttonEnabled: Driver<Bool>
        /// A sequence with a Void value when the login is successful
        let loginSuccessful: Driver<Void>
    }
}
