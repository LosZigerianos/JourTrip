//
//  Profile.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable {
	let success: Bool?
	let data: Profile?
	let error: String?
}

struct Profile: Codable {
	let fullname: String?
	let following, followers: Int?
	let comments: [Comment]?
	let photo: String?
	let provider, id, email, creationDate: String?
	let updatedAt, username: String?
}

struct Comment: Codable {
	let id: String?
	let user: Profile?
	let location: Location?
	let description, creationDate: String?
}
