//
//  MovieDetailsViewModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/24/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation

class MovieDetailsVM {
    var movie : MovieDetails!
    
    
    func getData(movieId: Int, completionHandler: @escaping (Bool) -> ()) {
        let dataHandler: (MovieDetails?, NetworkError)->Void = { (data, networkError) in
            self.movie = data
            completionHandler(networkError == .success)
        }
        UCProvider.INSTANCE.getMovieUC().getMovieDetails(movieId: movieId, completionHandler: dataHandler)
    }
    
    func getCastCount() -> Int {
        if movie == nil {
            return 0
        }
        return movie.getCastCount()
    }
    
    func getCast(index :Int) -> CastModel {
        return movie.getMovieCast(index:index)
    }
    
    func getRecommendationCount() -> Int {
        if movie == nil {
            return 0
        }
        return movie.getMovieRecommendations()
    }
    
    func getRecommendation(index :Int) -> MovieModel {
        return movie.getMovieRecommendation(index:index)
    }
    
    func release() {
        movie = nil
    }

}
