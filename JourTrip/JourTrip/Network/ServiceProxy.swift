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
    fileprivate func request(url : String, method: HTTPMethod, headers:HTTPHeaders?, parameters: Parameters?, completion:@escaping (_ response:Any?, _ error:NSError?) -> Void) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON  { (response) in
            
            if response.result.isSuccess {
                let jsonDic = response.result.value as! NSDictionary
                completion(jsonDic, nil)
            }
            completion(nil, self.failureRequest(url: url, response: response))
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

        guard let statusCode = response.response?.statusCode else {
            print("ServiceProxy: the request timed out")
            let errorStatus : Int = -1009
            return NSError(domain: url, code: errorStatus, userInfo: dictionary)
        }
        
        return NSError(domain: url, code: statusCode, userInfo: dictionary)
    }
    
    func getLocations(token:String, completion:@escaping (_ response:LocationsResponse?, _ error:NSError?) -> Void) {

        let url = ConstantNetworking.localUrl + ConstantNetworking.locations
//        "http://localhost:3000/apiv1/locations?name=Ayuntamiento&token=\(token)"
        
        Alamofire.request(url).responseObject { (response: DataResponse<LocationsResponse>) in
            print("\(response.request)")  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if response.result.isSuccess {
                let jsonDic = response.result.value as! LocationsResponse
                completion(jsonDic, nil)
                
            }
                //                else {
                //                    let httpError: NSError = response.result.error!
                //                    let statusCode = httpError.code
                //                    let error:NSDictionary = ["error" : httpError,"statusCode" : statusCode]
                //                    failureBlock(error: error)
                //                }
        }
    }

    func register(email: String, password: String, completion:@escaping (_ response:UserResponse?, _ error:NSError?) -> Void) {
        let parameters: Parameters = ["email": email, "password": password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.signup

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserResponse>) in
        
            if response.result.isSuccess {
                let jsonDic = response.result.value
                completion(jsonDic, nil)
            }
        }
    }
    
    func login(email: String, password: String, completion:@escaping (_ response:UserLogin?, _ error:NSError?) -> Void) {
        let parameters: Parameters = ["email": email, "password": password]
        
        let url = ConstantNetworking.localUrl + ConstantNetworking.login
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseObject  { (response: DataResponse<UserLogin>) in
            
            if response.result.isSuccess {
                let jsonDic = response.result.value
                completion(jsonDic, nil)
            }
        }
    }
}
