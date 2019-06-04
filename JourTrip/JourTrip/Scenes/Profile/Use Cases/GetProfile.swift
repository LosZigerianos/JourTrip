//
//  Profile.swift
//  JourTrip
//
//  Created by Alexandre on 04/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation


protocol ProfileProtocol {
    func invoke(with userID: String, completion: @escaping (ProfileResponse) -> ())
}

struct GetProfile: ProfileProtocol{
    private let repository: ProfileService
    
    init(repository: ProfileService) {
        self.repository = repository
    }
    
    func invoke(with userID: String, completion: @escaping (ProfileResponse) -> ()) {
        repository.getProfile(by: userID) { (response, error) in
            guard let profile = response else { fatalError("") }
            completion(profile)
        }
    }
}
