//
//  ConnectionProvider.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ConnectionProvider {

    static let INSTANCE: ConnectionProvider = {
        let _instance = ConnectionProvider()
        // Setup code
        return _instance
    }()
    
    func getData(urlString : String, completionHandler: @escaping (JSON?, NetworkError) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, .badURL)
            return
        }
        Alamofire.request(url).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            let json = try? JSON(data: data)
            completionHandler(json, .success)
        }
    }
    

    func postData(urlString : String, requestParams: [String : Any], completionHandler: @escaping (JSON?, NetworkError) -> ()) {
        
        let httpHeaders: HTTPHeaders = [
            "content-type": "application/json"
        ]
        guard let url = URL(string: urlString) else {
            completionHandler(nil, .badURL)
            return
        }
        // parameters that are needed to be posted in the backend
        Alamofire.request(url, method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON  { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            completionHandler(json, .success)
        }
        
    }
    
//    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
//        let urlToSearch = "https://en.wikipedia.org//w/api.php?//action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(searchText)&gpslimit=10"
//
//        Alamofire.request(urlToSearch).responseJSON { response in
//            guard let data = response.data else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            let json = try? JSON(data: data)
//            let results = json?["query"]["pages"].arrayValue
//            guard let empty = results?.isEmpty, !empty else {
//                completionHandler(nil, .failure)
//                return
//            }
//
//            completionHandler(results, .success)
//        }
//    }
    
}
