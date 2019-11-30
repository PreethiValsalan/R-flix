//
//  IMovieUC.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol IMovieUC {
    
    func getPopularMovies(page: Int, completionHandler: @escaping (MovieListWrapper?, NetworkError) -> ())
    
    func getTopRatedMovies(page: Int, completionHandler: @escaping (MovieListWrapper?, NetworkError) -> ())
    
    func getMovieDetails(movieId: Int, completionHandler: @escaping (MovieDetails?, NetworkError) -> ())
    
    func getGenres(completionHandler: @escaping (NSDictionary?, NetworkError) -> ())
    
}
