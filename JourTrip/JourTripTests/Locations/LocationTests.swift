//
//  LocationTests.swift
//  JourTripTests
//
//  Created by Alexandre on 03/12/2020.
//  Copyright © 2020 Los Zigerianos. All rights reserved.
//

import XCTest
@testable import JourTrip

final class LocationTests: XCTestCase {

    let location: Location = Location(geometry: nil, rating: Rating(totalVotes: 1, totalValues: 1, value: 5), description: "", photos: nil, tags: nil, comments: nil, id: nil, name: nil, address: nil, postalCode: nil, locale: nil, city: nil, state: nil, country: nil, formattedAddress: nil)
    
    func testLocationExistence() {
        XCTAssertNotNil(location)
    }
    
    func testDecodeLocationResponse() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "locations_response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let locations = try decoder.decode(Location.self, from: data)
            XCTAssertNotNil(locations)
        } catch {
            XCTFail()
        }
    }
}
