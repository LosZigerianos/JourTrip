//
//  ViewController.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    let email = "alexa@example.com"
    let password = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register example
        self.serviceProxy.register(email: email, password: password) { (response, error) in
            guard let email = response?.result?.email else {
                    fatalError("email or password error")
            }
            self.login(email: email, password: self.password)
        }
    }
    
    fileprivate func login(email: String, password: String) {
        // login example
        self.serviceProxy.login(email: email, password: password) { (response, error) in
            if let token = response?.token {
                self.getSomeLocations(with: token)
            }
        }
    }
    
    fileprivate func getSomeLocations(with token: String) {
        // Few locations example
        var ayuntamientos: [Location] = []
        
        self.serviceProxy.getLocations(token: token) { response, error in
            if let locations = response?.data {
                for location in locations {
                    ayuntamientos.append(location)
                }
            }
        }
    }
}
