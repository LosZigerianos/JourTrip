//
//  SignUpViewModel.swift
//  JourTrip
//
//  Created by Adrián Silva on 25/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct SignUpViewModel {

	let validator: SignUpValidatorType
	let service: RegisterServiceType

	init(validator: SignUpValidatorType,
		 service: RegisterServiceType) {
		self.validator = validator
		self.service = service
	}

	func transform(inputs: Inputs) -> Outputs {
		let emailValid = inputs.email
			.distinctUntilChanged()
			.throttle(0.2, scheduler: MainScheduler.instance)
			.map(validator.validate(email:))
			.asDriver(onErrorDriveWith: .empty())

		let passwordValid = inputs.password
			.distinctUntilChanged()
			.throttle(0.2, scheduler: MainScheduler.instance)
			.map(validator.validate(password:))
			.asDriver(onErrorDriveWith: .empty())

		let buttonEnabled = Driver
			.combineLatest(emailValid, passwordValid) { $0 && $1 }

		let credentials = Observable
			.combineLatest(inputs.email, inputs.password)

		let signUpSuccessful = inputs.buttonTap
			.withLatestFrom(credentials)
			.flatMap(service.register(with:))
			.asDriver(onErrorDriveWith: .never())

		return Outputs(buttonEnabled: buttonEnabled, signUpSuccesful: signUpSuccessful)
	}
}

extension SignUpViewModel {
	struct Inputs {
		let name: Observable<String>
		let email: Observable<String>
		let username: Observable<String>
		let password: Observable<String>
		let buttonTap: Observable<Void>
	}

	struct Outputs {
		let buttonEnabled: Driver<Bool>
		let signUpSuccesful: Driver<Void>
	}
}
