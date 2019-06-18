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
    case delete
}

enum ApiEndpoint {
	case userLogin(credentials: Credentials)
	case userSignUp(credentials: Credentials)
	case locations(name: String)
	case nearLocations(latitude: Double, longitude: Double)
	case profile(userID: String)
	case comments(userID: String)
	case deleteComment(commentId: String)
	case postComment
}

extension ApiEndpoint {
	func request<T: Encodable>(with baseURL: URL, andBody body: T) -> URLRequest {
		let url = baseURL.appendingPathComponent(path)

		let data = try! JSONEncoder().encode(body)

		var request = URLRequest(url: url)
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = method.rawValue
		request.httpBody = data

		return request
	}

	func request(with baseURL: URL, adding parameters: [String: String] = [:]) -> URLRequest {
		let url = buildUrl(with: baseURL, adding: parameters)

		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue

		print(request.url!)

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
		case .locations, .nearLocations, .profile, .comments:
			return .get
		case .userLogin, .userSignUp, .postComment:
			return .post
        case .deleteComment:
            return .delete
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
		case .profile(let userId):
			return "/users/profile/\(userId)"
		case .comments(let userId):
			return "/comments/userId/\(userId)/timeline"
        case .deleteComment(let commentId):
            return "/comments/\(commentId)/delete"
		case .postComment:
			return "/comments/add"
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
		default:
			return [:]
		}
	}
}
