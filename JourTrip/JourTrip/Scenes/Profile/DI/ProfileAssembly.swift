//
//  ProfileAssembly.swift
//  JourTrip
//
//  Created by Alexandre on 02/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

class ProfileAssembly {
    private let repository: ProfileService
    
    init(repository: ProfileService) {
        self.repository = repository
    }
    
    func viewController() -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.profileProtocol = getProfile()
        viewController.followerProtocol = getFollowers()
        
        return viewController
    }

    func getProfile() -> ProfileProtocol {
        return GetProfile(repository: repository)
    }
    
    func getFollowers() -> FollowerProtocol {
        return GetFollowers(repository: repository)
    }
}
