//
//  Feed.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import ObjectMapper

final class FeedResponse: Mappable {
    var success: Bool?
    var data: [Comment]?
    var error: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
        error <- map["error"]
    }
}
