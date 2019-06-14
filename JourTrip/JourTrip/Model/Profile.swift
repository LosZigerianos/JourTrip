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
	let id: String
    let user: Profile?
    let location: Location?
    let description, commentDescription, creationDate: String?
}

extension Comment {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case location
        case description, commentDescription
        case creationDate = "creation_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        user = try values.decodeIfPresent(Profile.self, forKey: .user)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        commentDescription = try values.decodeIfPresent(String.self, forKey: .commentDescription)
        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
    }
    
    var proxyForEquality: String {
        return "\(id)"
    }
}

extension Comment: Equatable {
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
