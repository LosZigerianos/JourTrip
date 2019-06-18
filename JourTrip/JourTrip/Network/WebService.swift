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

final class WebService: LoginServiceType, RegisterServiceType, LocationsServiceType, ProfileService, FeedService {
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
				self.saveLoginCredentials(credentials, for: response.metadata?.id)
			}
		}.resume()
	}

	func login(with credentials: Credentials) -> Single<Bool> {
		let user = UserModel(email: credentials.email, password: credentials.password)
		return load(UserLogin.self, from: .userLogin(credentials: credentials), withBody: user)
			.do(onNext: { user in
				self.saveLoginCredentials(credentials, for: user.metadata?.id)
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
				let response = try? self.decoder.decode(UserSignUp.self, from: data) {
				completion(response.success, nil)
				self.saveLoginCredentials(credentials, for: response.data.id)
			}
		}.resume()
	}

	func register(with credentials: Credentials) -> Single<Bool> {
		let user = UserModel(email: credentials.email, password: credentials.password)
		return load(UserSignUp.self, from: .userSignUp(credentials: credentials), withBody: user)
			.do(onNext: { response in
				self.saveLoginCredentials(credentials, for: response.data.id)
			})
			.map { $0.success }
			.asSingle()
	}
	
    // MARK: - Feed Service
    func getTimeline(completion: @escaping (FeedResponse?, Error?) -> Void) {
		let token = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.token) as! String
		let userId = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.id) as! String
		print(token)
		let request = ApiEndpoint.comments(userID: userId).request(with: baseUrl, adding: ["token": token])
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(FeedResponse.self, from: data) {
				completion(response, nil)
			}
		}.resume()
    }
    
    // MARK: - Profile Service
    func getProfile(completion: @escaping (ProfileResponse?, Error?) -> Void) {
		let token = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.token) as! String
		let userId = DataManager.sharedInstance.loadValue(key: ConstantsDataManager.id) as! String
        let request = ApiEndpoint.profile(userID: userId).request(with: baseUrl, adding: ["token": token])
		session.dataTask(with: request) { data, _, error in
			if let error = error {
				completion(nil, error)
			}

			if let data = data,
				let response = try? self.decoder.decode(ProfileResponse.self, from: data) {
				completion(response, nil)
			}
		}.resume()
    }

    // MARK: - Locations Service
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

	private func saveLoginCredentials(_ credentials: Credentials, for userId: String?) {
		DataManager.sharedInstance.save(value: credentials.email, key: ConstantsDataManager.email)
		DataManager.sharedInstance.save(value: credentials.password, key: ConstantsDataManager.password)
		if let id = userId {
			DataManager.sharedInstance.save(value: id, key: ConstantsDataManager.id)
		}
	}

	private func load<T: Decodable>(_ type: T.Type, from endpoint: ApiEndpoint, withBody body: UserModel) -> Observable<T> {
		let decoder = self.decoder
		let request = endpoint.request(with: baseUrl, andBody: body)

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
