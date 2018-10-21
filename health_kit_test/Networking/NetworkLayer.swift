//
//  NetworkLayer.swift
//  health_kit_test
//
//  Created by Neil Goldader on 10/19/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let API_KEY = UserDefaults.standard.object(forKey: "apikey")

let parameters: [String: Any] = [
    "apikey": UserDefaults.standard.object(forKey: "apikey"),
    "type" : "",
    "state" : ""
]

let REG_URL = "https://ballori2.wixsite.com/mysite/_functions/register"

let STATUS_URL = "https://ballori2.wixsite.com/mysite/_functions/sendStatus"

class NetworkLayer {
    
    init() {
        
    }
    
    // HTTP POST to send sleep data via HousemateAPI
    func httpPostSleep(type: String, state: String) {
        let parameters: Parameters = [
            "api": API_KEY,
            "type" : type,
            "state" : state
        ]
        Alamofire.request(STATUS_URL + "/sendSleep", method: .post, parameters: parameters, encoding: JSONEncoding.default) .responseJSON {
            response in
            print(response.request)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    func httpPostRegister(input: String, onSuccess: @escaping (Bool) -> Void) {
        let parameters: Parameters = [
            "accesscode": input
        ]
        Alamofire.request(REG_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default) .responseJSON {
            response in
            if let jsonResponse = response.result.value {
                print("JSON: \(jsonResponse)")
                let jsonify = JSON(jsonResponse)
                // TODO: Error handle no access key
                let status = (jsonify["status"] == "success") ? true : false
                if (status) {
                    print("Writing APIKEY to memory: " + jsonify["apikey"].stringValue)
                    UserDefaults.standard.set(jsonify["apikey"].stringValue, forKey: "apikey")
                }
                onSuccess(status)
            }
        }
    }
    
    // Request changes made to config
    func getConfigChanges() {
        Alamofire.request(STATUS_URL + "/getConfig", method: .get, parameters: parameters) .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
