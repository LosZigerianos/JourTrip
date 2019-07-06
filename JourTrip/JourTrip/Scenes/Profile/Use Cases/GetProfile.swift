//
//  Profile.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol ProfileProtocol {
    func invoke(completion: @escaping (ProfileResponse) -> ())
    func deleteComment(with commentID: String, completion: @escaping (ProfileResponse) -> ())
}

struct GetProfile: ProfileProtocol{
    
    private let repository: ProfileService
    
    init(repository: ProfileService) {
        self.repository = repository
    }
    // TODO: error handling
    func invoke(completion: @escaping (ProfileResponse) -> ()) {
        repository.getProfile() { (response, error) in
            guard let profile = response else { return }
            completion(profile)
        }
    }
    
    func deleteComment(with commentID: String, completion: @escaping (ProfileResponse) -> ()) {
        repository.deleteComment(with: commentID) { (response, error) in
            guard let profile = response else { return }
            completion(profile)
        }
    }
    
    
}
