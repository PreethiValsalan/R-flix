//
//  MovieUC.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieUC: IMovieUC {
    
    func getPopularMovies(page: Int, completionHandler: @escaping (MovieListWrapper?, NetworkError) -> ()) {
        let req_token = UserDefaults.standard.string(forKey: "REQUEST_TOKEN");
        if(req_token == nil) {
            completionHandler(nil, .sessionNotAvailable)
            return
        }
        let popularUrl = APIConstants.GET_POPULAR_MOVIES + "&page=\(page)"
        
        
        let popularHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["total_results"].intValue > 0) {
                let wrapper = MovieListWrapper(json : data!)
                completionHandler(wrapper, .success)
            }
            else {
                completionHandler(nil, .dataNotAvailablw)
            }
        }
        
        ConnectionProvider.INSTANCE.getData(urlString: popularUrl, completionHandler: popularHandler)
    }
    
    func getTopRatedMovies(page: Int, completionHandler: @escaping (MovieListWrapper?, NetworkError) -> ()) {
        let req_token = UserDefaults.standard.string(forKey: "REQUEST_TOKEN");
        if(req_token == nil) {
            completionHandler(nil, .sessionNotAvailable)
            return
        }
        let popularUrl = APIConstants.GET_TOP_RATED_MOVIES + "&page=\(page)"
        
        
        let topRatedHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["total_results"].intValue > 0) {
                let wrapper = MovieListWrapper(json : data!)
                completionHandler(wrapper, .success)
            }
            else {
                completionHandler(nil, .dataNotAvailablw)
            }
        }
        
        ConnectionProvider.INSTANCE.getData(urlString: popularUrl, completionHandler: topRatedHandler)
    }
    
    func getGenres(completionHandler: @escaping (NSDictionary?, NetworkError) -> ()) {
        let req_token = UserDefaults.standard.string(forKey: "REQUEST_TOKEN");
        if(req_token == nil) {
            completionHandler(nil, .sessionNotAvailable)
            return
        }
        let genreHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            
            if let genresArr = data!["genres"].array {
                let genreDictionary = NSMutableDictionary(capacity: genresArr.count)
                for genreJson in genresArr {
                    genreDictionary.setValue(genreJson["name"].stringValue, forKey: (genreJson["id"].stringValue))
                }
                completionHandler(genreDictionary, .success)
            }
            else {
                completionHandler(nil, .dataNotAvailablw)
            }
        }
        
        ConnectionProvider.INSTANCE.getData(urlString: APIConstants.GET_GENRES, completionHandler: genreHandler)
    }
    
    
    func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetails?, NetworkError) -> ()) {
        let req_token = UserDefaults.standard.string(forKey: "REQUEST_TOKEN");
        if(req_token == nil) {
            completionHandler(nil, .sessionNotAvailable)
            return
        }
        let movieUrl = String(APIConstants.GET_MOVIE_DETAILS+"\(movieId)?api_key="+APIConstants.API_KEY+"&append_to_response=credits,recommendations");
        
        
        let movieHandler: (JSON?, NetworkError)->Void = { (data, networkError) in
            if(data!["id"].intValue > 0) {
                let wrapper = MovieDetails(json : data!)
                completionHandler(wrapper, .success)
            }
            else {
                completionHandler(nil, .dataNotAvailablw)
            }
        }
        
        ConnectionProvider.INSTANCE.getData(urlString: movieUrl, completionHandler: movieHandler)
    }
}
