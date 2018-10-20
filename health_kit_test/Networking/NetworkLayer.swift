//
//  NetworkLayer.swift
//  health_kit_test
//
//  Created by Neil Goldader on 10/19/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import Foundation
import Alamofire

let API_KEY = "1234"

let parameters: [String: Any] = [
    "apikey": "1234",
    "type" : "",
    "state" : ""
]

let URL = "https://ballori2.wixsite.com/mysite/_functions/sendStatus"

class NetworkLayer {
    
    init() {
        
    }
    
    // HTTP POST to send sleep data via HealthyHomeAPI
    func httpPost(type: String, state: String) {
        let parameters: Parameters = [
            "apikey": API_KEY,
            "type" : type,
            "state" : state
        ]
        Alamofire.request(URL + "/sendSleep", method: .post, parameters: parameters, encoding: JSONEncoding.default) .responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    // Request changes made to config
    func getConfigChanges() {
        Alamofire.request(URL + "/getConfig", method: .get, parameters: parameters) .responseJSON { response in
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
