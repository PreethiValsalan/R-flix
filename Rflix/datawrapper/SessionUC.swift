//
//  SessionUC.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class SessionUC: ISessionUC {
    
    func getToken(completionHandler: @escaping (JSON?, NetworkError) -> ()) {
        ConnectionProvider.INSTANCE.getData(urlString: APIConstants.GET_TOKEN_API, completionHandler: completionHandler)
    }
    
    
    func authenticate(username: String, password: String, completionHandler: @escaping (JSON?, NetworkError) -> ()) {
        
        let loginHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["success"].boolValue) {
                let req_token = data!["request_token"].stringValue
                UserDefaults.standard.set(req_token, forKey:"REQUEST_TOKEN")
                completionHandler(data, .success)
                
            } else {
                print("Error")
                completionHandler(data, .failure)
            }
            
        }
        let tokenHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["success"].boolValue) {
                let req_token = data!["request_token"].stringValue
                let params = [
                    "username": username,
                    "password": password,
                    "request_token": req_token
                    ] as [String : Any]
                ConnectionProvider.INSTANCE.postData(urlString: APIConstants.POST_AUTHENTICATE_API, requestParams: params, completionHandler: loginHandler)
                
            } else {
                print("Error")
            }
            
        }
        getToken(completionHandler: tokenHandler)
  
    }
    
    
 
}
