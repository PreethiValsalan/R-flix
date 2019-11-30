//
//  UCProvider.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation

class UCProvider {
    static let INSTANCE: UCProvider = {
        let _instance = UCProvider()
        // Setup code
        return _instance
    }()
    
    private let movieUC = MovieUC()
    private let sessionUC = SessionUC()
    
    func getMovieUC() -> IMovieUC {
        return movieUC
    }
   
    func getSessionUC() -> ISessionUC {
        return sessionUC
    }
}
