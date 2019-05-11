//
//  LocationsResponse.swift
//  JourTrip
//
//  Created by Alexandre on 29/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

final class LocationsResponse: Mappable {
    var success: Bool?
    var count: Int?
    var data: [Location]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        count <- map["count"]
        data <- map["data"]
        
    }
}

final class Location: Mappable {
    var coordinates: Coordinates?
    var rating: Rating?
    var description: String?
    var photos: [String]?
    var tags: [String] = []
    var comments: [String] = []
    var id, name, address: String?
    var postalCode: String?
    var locale, city, state, country: String?
    var formattedAddress: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        coordinates <- map["coordinates"]
        rating <- map["rating"]
        description <- map["description"]
        photos <- map["photos"]
        tags <- map["tags"]
        comments <- map["comments"]
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        postalCode <- map["postalCode"]
        locale <- map["cc"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
        formattedAddress <- map["formattedAddress"]
    }
}

final class Coordinates: Mappable {
    var latitude: String?
    var longitude: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}

final class Rating: Mappable {
    var totalVotes: Int?
    var totalValues: Int?
    var value: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalVotes <- map["totalVotes"]
        totalValues <- map["totalValues"]
        value <- map["value"]
    }
}
