//
//  CommonMovieViewModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
class CommonMoviesVM {
    var movies : NSMutableArray!
    var totalMoviesReq = 0;
    
    init(totalMovies : Int) {
        totalMoviesReq = totalMovies;
        movies = NSMutableArray.init()
        
    }
    
    func getData(pageNo: Int, completionHandler: @escaping (Bool) -> ()) {
        preconditionFailure("This method must be overridden")
    }
    
    func getGenres(completionHandler: @escaping (Bool) -> ()) {
        let dataHandler: (NSDictionary?, NetworkError)->Void = { (data, networkError) in
            for movie in self.movies {
                let movieModel = movie as! MovieModel
                movieModel.setGenreNames(allgenres: data!)
            }
            completionHandler(networkError == .success)
        }
        UCProvider.INSTANCE.getMovieUC().getGenres(completionHandler: dataHandler)
    }
    
    func getMovieCount() -> Int {
        return movies.count
    }
    
    func getMovie(index : Int) -> MovieModel {
        return movies.object(at: index) as! MovieModel
    }
    
    func shdLoadMore(index : Int) -> Bool{
        if index == movies.count - 1 { // last cell
            if totalMoviesReq > movies.count { // more items to fetch
                return true
            }
        }
        return false
    }
    
}
