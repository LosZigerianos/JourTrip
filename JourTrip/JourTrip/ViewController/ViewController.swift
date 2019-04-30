//
//  ViewController.swift
//  JourTrip
//
//  Created by Alexandre on 23/4/19.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: BaseViewController {
    
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // signup example
        self.serviceProxy.register(email: "alex14@example.com", password: "1234") { (response, error) in
            let userTest = response?.result
            print(userTest ?? "")
        }
        
        // login example
        self.serviceProxy.login(email: "alex13@example.com", password: "1234") { (response, error) in
            if let token = response?.token {
                self.token = token
            }
        }
        
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
