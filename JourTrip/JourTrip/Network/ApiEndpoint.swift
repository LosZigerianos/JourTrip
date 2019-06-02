//
//  ApiEndpoint.swift
//  JourTrip
//
//  Created by Adrián Silva on 31/05/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

enum RequestType: String {
	case get
	case post
}

enum ApiEndpoint {
	case userLogin(credentials: Credentials)
	case userSignUp(credentials: Credentials)
	case locations(name: String)
	case nearLocations(latitude: Double, longitude: Double)
}

extension ApiEndpoint {
	func request(with baseURL: URL, adding parameters: [String: String]? = nil) -> URLRequest {
		let url = baseURL.appendingPathComponent(path)

		var newParameters = self.parameters
		parameters?.forEach { newParameters.updateValue($1, forKey: $0) }

		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = newParameters.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		request.httpMethod = method.rawValue

		return request
	}

	func buildUrl(with baseURL: URL, adding parameters: [String: String] = [:]) -> URL {
		let url = baseURL.appendingPathComponent(path)

		var newParameters = self.parameters
		parameters.forEach { newParameters.updateValue($1, forKey: $0) }

		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = newParameters.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		return request.url!
	}


}

extension ApiEndpoint {
	var method: RequestType {
		switch self {
		case .locations, .nearLocations:
			return .get
		case .userLogin, .userSignUp:
			return .post
		}
	}

	var path: String {
		switch self {
		case .locations:
			return "/locations"
		case .nearLocations:
			return "/locations/near"
		case .userLogin:
			return "/users/login"
		case .userSignUp:
			return "/users/signup"
		}
	}

	var parameters: [String: String] {
		switch self {
		case .locations(let name):
			return [
				"name": name
			]
		case .nearLocations(let latitude, let longitude):
			return [
				"latitude": String(latitude),
				"longitude": String(longitude)
			]
		case .userSignUp(let credentials):
			return [
				"email": credentials.email,
				"password": credentials.password
			]
		case .userLogin(let credentials):
			return [
				"email": credentials.email,
				"password": credentials.password
			]
		}
	}
}
