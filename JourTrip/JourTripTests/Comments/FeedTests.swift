//
//  FeedTests.swift
//  JourTripTests
//
//  Created by Alexandre on 04/12/2020.
//  Copyright © 2020 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import JourTrip

final class FeedTests: XCTestCase {
    
    let feed: Comment = Comment(id: "1", user: Profile(fullname: "Admin", following: 1, followers: 1, comments: [], photo: nil, provider: nil, id: nil, email: "admin@jwt.com", creationDate: "", updatedAt: "", username: "invitado"), location: Location(geometry: nil, rating: Rating(totalVotes: 2, totalValues: 2, value: 1), description: "", photos: nil, tags: nil, comments: nil, id: nil, name: nil, address: nil, postalCode: nil, locale: "", city: "Barcelona", state: "", country: "Spain", formattedAddress: ""), description: "", creationDate: nil)
    
    func testFeedExistence() {
        XCTAssertNotNil(feed)
    }
    
    func testDecodeFeedResponse() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "feed_response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let comments = try decoder.decode(Comment.self, from: data)
            XCTAssertNotNil(comments)
        } catch {
            XCTFail()
        }
    }
}
