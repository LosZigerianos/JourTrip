//
//  UserResponse.swift
//  JourTrip
//
//  Created by Alexandre on 27/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
	let success: Bool
	let metadata: Metadata
	let token: String
}

extension UserLogin {
	enum CodingKeys: String, CodingKey {
		case success
		case metadata
		case token = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decode(Bool.self, forKey: .success)
		metadata = try values.decode(Metadata.self, forKey: .metadata)
		token = try values.decode(String.self, forKey: .token)
	}
}

struct Metadata: Codable {
	let fullname: String?
	let following: [String]?
	let provider: String?
	let id: String?
	let email: String?
	let creationDate: String?
	let updatedAt: String?
}

extension Metadata {
	enum CodingKeys: String, CodingKey {
		case fullname, following, provider, email
		case id = "_id"
		case creationDate = "creation_date"
		case updatedAt = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
		following = try values.decodeIfPresent([String].self, forKey: .following)
		provider = try values.decodeIfPresent(String.self, forKey: .provider)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
	}
}

struct UserResponse: Codable {
	let success: Bool
	let result: UserModel
}

struct UserModel: Codable {
	let email: String
	let password: String
}
