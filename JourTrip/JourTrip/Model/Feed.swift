//
//  Feed.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

struct FeedResponse: Codable {
	let success: Bool?
	let data: [Comment]?
	let error: String?
}
