//
//  ApiCommunicator.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import Foundation
import Alamofire

class ApiCommunicator {
    
    var baseUrl: String
    var api_url: String
    
    init(subPath: String?) {
        
        baseUrl = ApiUrl
        api_url = "\(baseUrl)/"
        
        if let path = subPath {
            api_url += "\(path)/"
        }
        
    }
    
    func callApi(endpoint: String, params: [String:Any]?, method: HTTPMethod, completionObject: ((NSDictionary?, String, Int, Int) -> Void)?) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        if ApiDebugLoggingEnabled {
            print("------------- REQUEST -------------")
            dump(headers)
            dump(params)
            print("\(api_url)\(endpoint)")
        }
        
        Alamofire.request("\(api_url)\(endpoint)", method: method, parameters: params, headers: headers)
            .responseJSON(completionHandler: { (response) in
                
                let error = response.result.error
                let value = response.result.value
                let code = response.response?.statusCode
                
                var message: String
                if response.response == nil {
                    message = "Please check your internet connection."
                } else {
                    message = "Server error"
                }
    
                if error != nil {
                    NSLog("[APIClient] | [\(endpoint)] | Error = \(String(describing: error?.localizedDescription))")
                    completionObject?(nil, message, code ?? FailureStatus, FailureStatus)
                    
                } else if let object = value as? NSDictionary {
                    completionObject?(object, message, code ?? SuccessStatus, SuccessStatus)
                    
                } else {
                    NSLog("[APIClient] | [\(endpoint)] | response.value is nil")
                    completionObject?(nil, message, code ?? FailureStatus, FailureStatus)
                }
                
            })
            .responseString { (res) in
                if ApiDebugLoggingEnabled {
                    print("------------- RESPONSE -------------")
                    print(res.response?.statusCode ?? "No status code found")
                    dump(res.result.value ?? "result.value is nil")
                }
        }
        
    }
    
}
