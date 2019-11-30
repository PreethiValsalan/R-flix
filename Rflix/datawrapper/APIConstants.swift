//
//  APIConstants.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
class APIConstants {
    
    static let HOME_API = "https://api.themoviedb.org"
    
    static let API_KEY = "a5bff9ee676c3645029f0247031dbec2";
    static let GET_TOKEN_API = HOME_API+"/3/authentication/token/new?api_key="+API_KEY;
    static let POST_AUTHENTICATE_API = HOME_API+"/3/authentication/token/validate_with_login?api_key="+API_KEY;
    static let GET_POPULAR_MOVIES = HOME_API+"/3/movie/popular?api_key="+API_KEY;
    
    static let GET_TOP_RATED_MOVIES = HOME_API+"/3/movie/top_rated?api_key="+API_KEY;
    static let GET_MOVIE_DETAILS = HOME_API+"/3/movie/"
    
    static let GET_GENRES = HOME_API+"/3/genre/movie/list?api_key="+API_KEY;
    
    static let IMG_PATH_W92 = "http://image.tmdb.org/t/p/w92";
    static let IMDB_PATH = "http://www.imdb.com/title/";
}
