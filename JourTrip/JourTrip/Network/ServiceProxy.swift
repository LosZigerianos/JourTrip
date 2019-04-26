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

/*
 Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON  { (response) in
 
 switch response.result {
 case .success:
 if let data = response.data {
 completion(data, nil)
 }
 case .failure(_ as NSError):
 completion(nil, self.failureRequest(url: url, response: response))
 default:
 break
 }
 }
 */

class ServiceProxy: NSObject {
    fileprivate func request(url: String, method: HTTPMethod, headers: HTTPHeaders?, parameters: Parameters?, completion:@escaping (_ response:Any?, _ error:NSError?) -> Void) {
        
        Alamofire.request(url).responseObject { (response: DataResponse<User>) in
            
            let weatherResponse = response.result.value
            print(weatherResponse?.email as Any)
            //TODO: handle json
//            if let threeDayForecast = weatherResponse?.threeDayForecast {
//                for forecast in threeDayForecast {
//                    print(forecast.day)
//                    print(forecast.temperature)
//                }
//            }
        }
        
    }
    
    fileprivate func failureRequest(url:String, response:DataResponse<Any>) -> NSError {
        var dictionary : JSONDictionary = [:]
        
        if let data = response.data {
            do {
                let json = String(data: data, encoding: String.Encoding.utf8)!
                dictionary = try JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [String:Any]
            } catch {
                print("An error ocurred: \(String(describing: response.error?.localizedDescription))")
            }
        }
        // TODO: Show alert
        guard let statusCode = response.response?.statusCode else {
            print("ServiceProxy: the request timed out")
            let errorStatus : Int = -1009
            return NSError(domain: url, code: errorStatus, userInfo: dictionary)
        }
        
        return NSError(domain: url, code: statusCode, userInfo: dictionary)
    }
    
    func login(email: String, password: String, completion:@escaping (_ response:User?, _ error:NSError?) -> Void) {
        let parameters : Parameters = [
            "email": email,
            "password": password
        ]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.login
        
        self.request(url: url, method: .post, headers: nil, parameters: parameters) { (response, error) in
            
            if (error != nil) {
                completion(nil, error)
            }
            let data: User? = nil
            // TODO: map user
            completion(data, nil)
        }
    }

    func register(user: User, password: String, completion:@escaping (_ response:User?, _ error:NSError?) -> Void) {
        let parameters : Parameters = [
            "name": user.name,
            "email": user.email,
            "password": password
        ]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.signUp
        
        self.request(url: url, method: .post, headers: nil, parameters: parameters) { (response, error) in
            if (error != nil) {
                completion(nil, error)
            } else {
                let data: User? = nil
                // TODO: map user
                completion(data, nil)
            }
        }
    }
    
    func getLocations(token: String, completion:@escaping (_ response:Location?, _ error:NSError?) -> Void) {
        let headers: HTTPHeaders = ["x-access-token" : token, "Content-Type": "application/json"]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.locations
        
        self.request(url: url, method: .get, headers: headers, parameters: nil) { (response, error) in
            if error != nil {
                completion(nil, error)
            }
            let data: Location? = nil
             // TODO: map location
            completion(data, nil)
        }
    }
    
    func getComments(token: String, id: String?, completion:@escaping (_ response:Comment?, _ error:NSError?) -> Void) {
        let headers: HTTPHeaders = ["x-access-token" : token, "Content-Type": "application/json"]
        
        var url = ConstantNetworking.localUrl + ConstantNetworking.allMessages
        
        if let id = id {
            url = url + "?id=\(id)"
        }
        
        self.request(url: url, method: .get, headers: headers, parameters: nil) { (response, error) in
            if error != nil {
                completion(nil, error)
            }
            let data: Comment? = nil
            // TODO: map comment
            completion(data, nil)
        }
    }
}
