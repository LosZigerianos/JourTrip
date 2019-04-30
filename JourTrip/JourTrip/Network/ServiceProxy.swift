//
//  ServiceProxy.swift
//  JourTrip
//
//  Created by Alexandre on 25/04/2019.
//  Copyright © 2019 Los Zigerianos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ServiceProxy: NSObject {
    
    func register(email: String, password: String, completion:@escaping (_ response:UserResponse?, _ error:NSError?) -> Void) {
        let parameters: Parameters = ["email": email, "password": password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.signup
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserResponse>) in
            if response.result.isSuccess {
                let userResponse = response.result.value
                completion(userResponse, nil)
            }
        }
    }
    
    func login(email: String, password: String, completion:@escaping (_ response:UserLogin?, _ error:NSError?) -> Void) {
        let parameters: Parameters = ["email": email, "password": password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.login
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserLogin>) in
            if response.result.isSuccess {
                let json = response.result.value
                completion(json, nil)
            }
        }
    }
    
    func getLocations(token:String, completion:@escaping (_ response:LocationsResponse?, _ error:NSError?) -> Void) {
        let url = ConstantNetworking.localUrl + ConstantNetworking.locations + "?name=Ayuntamiento&token=\(token)"
        
        Alamofire.request(url).responseObject { (response: DataResponse<LocationsResponse>) in
            if let locationsResponse = response.result.value as LocationsResponse? {
                completion(locationsResponse, nil)
            }
            completion(nil, response.error as NSError?)
        }
    }
}
