//
//  MovieListWrapper.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieListWrapper {
    private(set) var pageNo = 1
    private(set) var totalResults = 0
    private var movieArray : NSMutableArray
    
    init(json : JSON) {
        pageNo = json["page"].intValue
        totalResults = json["total_results"].intValue
        let movieJsons = json["results"].array!
        movieArray = NSMutableArray(capacity: (movieJsons.count))
        for movie in movieJsons {
            movieArray.add(MovieModel(json : movie))
        }
    }
    
    func getMovies() -> NSArray {
        return movieArray
    }
    
}
