//
//  GetFollowers.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol FollowerProtocol {
    func getFollowing(completion: @escaping (ProfilesResponse) -> ())
    func getFollowers(completion: @escaping (ProfilesResponse) -> ())
}

struct GetFollowers: FollowerProtocol {
    
    private let repository: ProfileService
    
    init(repository: ProfileService) {
        self.repository = repository
    }
    
    func getFollowing(completion: @escaping (ProfilesResponse) -> ()) {
        repository.getFollowing() { (response, error) in
            guard let profile = response else { return }
            completion(profile)
        }
    }
    
    func getFollowers(completion: @escaping (ProfilesResponse) -> ()) {
        repository.getFollowers() { (response, error) in
            guard let profile = response else { return }
            completion(profile)
        }
    }
    
    
}
