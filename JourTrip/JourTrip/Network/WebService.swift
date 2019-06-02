//
//  WebService.swift
//  JourTrip
//
//  Created by Adrián Silva on 31/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift
import Simple_KeychainSwift

final class WebService: LoginServiceType, RegisterServiceType, LocationsServiceType {
	let token = DataManager.sharedInstance.loadValue(key: "token") as! String
	let baseUrl = URL(string: "https://api.jourtrip.ml/apiv1")!
	let webServiceParameters: [String: String]

	init() {
		webServiceParameters = ["token": token]
	}

	func login(with credentials: Credentials, completion: @escaping (UserLogin?, Error?) -> Void) {
		let endpoint = ApiEndpoint.userLogin(credentials: credentials)
		AF.request(endpoint.buildUrl(with: baseUrl),
				   method: .post,
				   parameters: endpoint.parameters,
				   encoding: JSONEncoding.default,
				   headers: nil)
			.validate()
			.responseObject { (response: DataResponse<UserLogin>) in
			// todo: check error
			if response.result.isSuccess {
				guard let userLogin = response.result.value,
					let metadata = userLogin.metadata,
					let userID = metadata.id,
					let token = userLogin.token else {
						fatalError("no token provided")
				}
				DataManager.sharedInstance.save(value: token, key: "token")
				_ = DataManager.sharedInstance.saveSecure(value: userID, key: ConstantsDataManager.id)
				RealmManager.sharedInstance.save(user: userLogin)

				completion(userLogin, nil)
			}
		}
	}

	func login(with credentials: Credentials) -> Single<Void> {
		return Single.create { observer in
			self.login(with: credentials) { response, error in
				if let error = error {
					observer(.error(error))
				}

				if let _ = response {
					observer(.success(()))
				}
			}
			return Disposables.create()
		}
	}

	func register(with credentials: Credentials, completion: @escaping (UserResponse?, Error?) -> Void) {
		let endpoint = ApiEndpoint.userSignUp(credentials: credentials)
		AF.request(endpoint.buildUrl(with: baseUrl),
				   method: .post,
				   parameters: endpoint.parameters,
				   encoding: JSONEncoding.default,
				   headers: nil)
			.validate()
			.responseObject { (response: DataResponse<UserResponse>) in
				if response.result.isSuccess {
					let userResponse = response.result.value
					completion(userResponse, nil)
				}
		}
	}

	func register(with credentials: Credentials) -> Single<Void> {
		return Single.create { observer in
			self.login(with: credentials) { response, error in
				if let error = error {
					observer(.error(error))
				}

				if let _ = response {
					observer(.success(()))
				}
			}
			return Disposables.create()
		}
	}

	func getLocations(byName name: String,
					  completion: @escaping (LocationsResponse?, Error?) -> Void) {
		let endpoint = ApiEndpoint.locations(name: name)
		request(with: endpoint, completion: completion)
	}

	func getNearLocations(latitude: Double,
						  longitude: Double,
						  completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void) {
		let endpoint = ApiEndpoint.nearLocations(latitude: latitude, longitude: longitude)
		request(with: endpoint, completion: completion)
	}

	private func request(with endpoint: ApiEndpoint,
						 completion: @escaping (_ response: LocationsResponse?, _ error: Error?) -> Void) {
		AF.request(endpoint.request(with: baseUrl, adding: webServiceParameters))
			.responseObject { (response: DataResponse<LocationsResponse>) in
				if let locationsResponse = response.result.value as LocationsResponse? {
					completion(locationsResponse, nil)
				} else {
					completion(nil, response.error as NSError?)
				}
		}
	}
}
