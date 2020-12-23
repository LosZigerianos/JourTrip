//
//  ProfileTests.swift
//  JourTripTests
//
//  Created by Alexandre on 04/12/2020.
//  Copyright © 2020 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import JourTrip

final class ProfileTests: XCTestCase {
    
    let profile = Profile(fullname: "Guest", following: 3, followers: 2, comments: nil, photo: nil, provider: nil, id: "123", email: "guest@jwt.com", creationDate: nil, updatedAt: nil, username: "Guest")
    
    func testProfileExistence() {
        XCTAssertNotNil(profile)
    }
    
    func testDecodeProfileResponse() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "profile_response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let profile = try decoder.decode(Profile.self, from: data)
            XCTAssertNotNil(profile)
        } catch {
            XCTFail()
        }
    }
}
