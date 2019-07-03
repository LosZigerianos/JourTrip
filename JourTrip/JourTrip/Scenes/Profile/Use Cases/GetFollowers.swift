//
//  GetFollowers.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol GetFollowersProtocol {
    func invoke(completion: @escaping (ProfileResponse) -> ())
}

struct GetFollowers: GetFollowersProtocol{
    
    private let repository: ProfileService
    
    init(repository: ProfileService) {
        self.repository = repository
    }
    
    func invoke(completion: @escaping (ProfileResponse) -> ()) {
        repository.getFollowers() { (response, error) in
            guard let profile = response else { return }
            completion(profile)
        }
    }
}
