//
//  PutUserData.swift
//  JourTrip
//
//  Created by Alexandre on 19/06/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import Foundation

protocol PutUserDataProtocol {
    func updateData(with username: String,
                    fullname: String,
                    emai: String,
                     completion: @escaping ([ProfileResponse]) -> ())
}

struct PutUserData: PutUserDataProtocol {
    
    private let repository: SettingsService
    
    init(repository: SettingsService) {
        self.repository = repository
    }
    
    func updateData(with username: String, fullname: String, emai: String, completion: @escaping ([ProfileResponse]) -> ()) {
        repository.putUserData(username: username, fullname: fullname, email: emai) { (response, error) in
            guard let updateDataResponse = response else { return }
            completion([updateDataResponse])
        }
        
    }
}
