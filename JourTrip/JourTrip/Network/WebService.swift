//
//  WebService.swift
//  JourTrip
//
//  Created by Adrián Silva on 31/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import RxSwift
import Simple_KeychainSwift

final class WebService: LoginServiceType, RegisterServiceType, LocationsServiceType {
	let baseUrl = URL(string: "https://api.jourtrip.ml/apiv1")!
	let session = URLSession.shared
	let decoder = JSONDecoder()

	func login(with credentials: Credentials, completion: @escaping (Bool?, Error?) -> Void) {
		let user = UserModel(email: credentials.email, password: credentials.password)
		let request = ApiEndpoint.userLogin(credentials: credentials).request(with: baseUrl, andBody: user)
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(UserLogin.self, from: data) {
				completion(response.success, nil)
				self.saveUserCredentials(credentials, token: response.token)
			}
		}.resume()
	}

	func login(with credentials: Credentials) -> Single<Bool> {
		let user = UserModel(email: credentials.email, password: credentials.password)
		return load(UserLogin.self, from: .userLogin(credentials: credentials), withBody: user)
			.do(onNext: { user in
				self.saveUserCredentials(credentials, token: user.token)
			})
			.map { $0.success }
			.asSingle()
	}

	func register(with credentials: Credentials, completion: @escaping (Bool?, Error?) -> Void) {
		let user = UserModel(email: credentials.email, password: credentials.password)
		let request = ApiEndpoint.userSignUp(credentials: credentials).request(with: baseUrl, andBody: user)
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(UserResponse.self, from: data) {
				completion(response.success, nil)
				self.saveUserCredentials(credentials, token: "")
			}
		}.resume()
	}

	func register(with credentials: Credentials) -> Single<Bool> {
		let user = UserModel(email: credentials.email, password: credentials.password)
		return load(UserResponse.self, from: .userSignUp(credentials: credentials), withBody: user)
			.do(onNext: { response in
				self.saveUserCredentials(credentials, token: "")
			})
			.map { $0.success }
			.asSingle()
	}

	func getLocations(byName name: String,
					  completion: @escaping (LocationsResponse?, Error?) -> Void) {
		let token = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.token) as! String
		let request = ApiEndpoint.locations(name: name).request(with: baseUrl, adding: ["token": token])
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(LocationsResponse.self, from: data) {
				completion(response, nil)
			}
		}.resume()
	}

	func getNearLocations(latitude: Double,
						  longitude: Double,
						  completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void) {
		let token = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.token) as! String
		let request = ApiEndpoint.nearLocations(latitude: latitude, longitude: longitude).request(with: baseUrl, adding: ["token": token])
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(LocationsResponse.self, from: data) {
				completion(response, nil)
			}
		}.resume()
	}

	private func saveUserCredentials(_ credentials: Credentials, token: String) {
		DataManager.sharedInstance.save(value: credentials.email, key: ConstantsDataManager.email)
		DataManager.sharedInstance.save(value: credentials.password, key: ConstantsDataManager.password)
		DataManager.sharedInstance.save(value: token, key: ConstantsDataManager.token)
	}

	private func load<T1: Decodable>(_ type: T1.Type, from endpoint: ApiEndpoint, withBody body: UserModel) -> Observable<T1> {
		let decoder = self.decoder
		let request = endpoint.request(with: baseUrl, andBody: ["email": body.email, "password": body.password])

		return session.rx.data(request: request)
			.map { try decoder.decode(type, from: $0) }
	}
}


private extension Reactive where Base: URLSession {
	func send(request: URLRequest) -> Observable<Data> {
		return Observable<Data>.create { observer in
			let task = self.base.dataTask(with: request) { data, response, error in
				if let error = error {
					observer.onError(error)
				} else {
					guard let httpResponse = response as? HTTPURLResponse else {
						fatalError("Unsupported protocol")
					}

					if 200 ..< 300 ~= httpResponse.statusCode {
						if let data = data {
							observer.onNext(data)
						}
						observer.onCompleted()
					}
				}
			}

			task.resume()

			return Disposables.create {
				task.cancel()
			}
		}
	}

}
