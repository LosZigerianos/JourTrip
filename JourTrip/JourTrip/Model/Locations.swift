//
//  LocationsResponse.swift
//  JourTrip
//
//  Created by Alexandre on 29/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

struct LocationsResponse: Codable {
	let success: Bool
	let count: Int
	let data: [Location]
}

struct Location: Codable {
	let geometry: Geometry?
	let rating: Rating?
	let description: String?
	let photos: [String]?
	let tags: [String]?
	let comments: [String]?
	let id, name, address: String?
	let postalCode: String?
	let locale: String?
	let city: String?
	let state:String?
	let country: String?
	let formattedAddress: String?
}

extension Location {
	enum CodingKeys: String, CodingKey {
		case geometry, rating, description
		case photos, tags, comments
		case id = "_id", name, address
		case postalCode, city, state
		case locale = "cc", country, formattedAddress
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
		rating = try values.decodeIfPresent(Rating.self, forKey: .rating)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		photos = try values.decodeIfPresent([String].self, forKey: .photos)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		comments = try values.decodeIfPresent([String].self, forKey: .comments)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
		locale = try values.decodeIfPresent(String.self, forKey: .locale)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		formattedAddress = try values.decodeIfPresent(String.self, forKey: .formattedAddress)
	}
}

struct Geometry: Codable {
	let type: String
	let coordinates: [Double]
}

struct Rating: Codable {
	let totalVotes: Int?
	let totalValues: Int?
	let value: Int?
}

