//
//  GetLocations.swift
//  JourTrip
//
//  Created by Alexandre on 10/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol GetTimelineProtocol {
    func invoke(with userID: String, completion: @escaping ([Comment]) -> ())
}

struct GetTimeline: GetTimelineProtocol {
    
    private let repository: FeedService
    
    init(repository: FeedService) {
        self.repository = repository
    }
    
    func invoke(with userID: String, completion: @escaping ([Comment]) -> ()) {
        repository.getTimeline() { response, error in
            guard let locations = response?.data else { return }
            completion(locations)
        }
    }
}
