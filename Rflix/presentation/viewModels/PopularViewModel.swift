//
//  PopularViewModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class PopularViewModel : CommonMoviesVM {

    
    override func getData(pageNo: Int, completionHandler: @escaping (Bool) -> ()) {

        let dataHandler: (MovieListWrapper?, NetworkError)->Void = { (data, networkError) in
            self.movies.addObjects(from: data?.getMovies() as! [MovieModel])
            completionHandler(networkError == .success)
        }
        UCProvider.INSTANCE.getMovieUC().getPopularMovies(page: pageNo, completionHandler: dataHandler)
    }
 
}
