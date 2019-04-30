//
//  LocationsResponse.swift
//  JourTrip
//
//  Created by Alexandre on 29/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

class LocationsResponse: Mappable {
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


class Coordinates: Mappable {
    var latitude: String?
    var longitude: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}

class Rating: Mappable {
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

class Location: Mappable {
//    var coordinates: Coordinates?
//    var rating: Rating?
    var description: String?
    var photos: [String]?
    var tags: [String]?
    var comments: [String] = []
    var id, name, address: String?
    var postalCode: String?
    var cc, city, state, country: String?
    var formattedAddress: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
//        coordinates <- map["coordinates"]
//        rating <- map["rating"]
        description <- map["description"]
        photos <- map["photos"]
        tags <- map["tags"]
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        comments <- map["comments"]
    }
}
