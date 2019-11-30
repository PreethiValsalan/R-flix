//
//  TopRatedViewModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

class TopRatedViewModel : CommonMoviesVM {
    
    override func getData(pageNo: Int, completionHandler: @escaping (Bool) -> ()) {
        let dataHandler: (MovieListWrapper?, NetworkError)->Void = { (data, networkError) in
            self.movies.addObjects(from: data?.getMovies() as! [MovieModel])
            completionHandler(networkError == .success)
        }
        UCProvider.INSTANCE.getMovieUC().getTopRatedMovies(page: pageNo, completionHandler: dataHandler)
    }
    
}
