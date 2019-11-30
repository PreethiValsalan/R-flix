//
//  MovieModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieModel {
    private(set) var poster : String?
    private(set) var title = ""
    private(set) var id : Int
    private(set) var releasedDate = ""
    private(set) var genreIds : [JSON];
    private(set) var genreValues : NSDictionary!
    
    /*
     A movie’s card should dis-
     play the following: its poster (image), title, year of release, genre(s),
     
     and your TMDb rating for this movie, if you’ve rated it, or its global
     TMDb rating otherwise (see Rate Movies below).
     
     "popularity": 366.368,
     "vote_count": 112,
     "video": false,
     "poster_path": "/qdfARIhgpgZOBh3vfNhWS4hmSo3.jpg",
     "id": 330457,
     "adult": false,
     "backdrop_path": "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
     "original_language": "en",
     "original_title": "Frozen II",
     "genre_ids": [
     12,
     16,
     35,
     10402,
     10751
     ],
     "title": "Frozen II",
     "vote_average": 6.6,
     "overview": "Elsa, Anna, Kristoff and Olaf are going far in the forest to know the truth about an ancient mystery of their kingdom.",
     "release_date": "2019-11-20"
 */
    init(json : JSON) {
        id = json["id"].int!
        poster = json["poster_path"].string!
        title = json["original_title"].string!
        releasedDate = json["release_date"].string!
        genreIds = json["genre_ids"].array!
        genreValues = NSMutableDictionary(capacity: genreIds.count)
    }
    
    func setGenreNames(allgenres : NSDictionary) {
        for genreId in genreIds {
            genreValues.setValue(allgenres[genreId.stringValue] as! String, forKey: (genreId.stringValue))
        }
    }
    
    func getGenreString() -> String {
        var genre = ""
        var i = 0;
        for genreId in genreIds {
            if(i > 0) {
                genre = genre + ","
            }
            i = i + 1
            let genreV = genreValues.value(forKey: genreId.stringValue) as! String
            genre = genre + genreV + ","
        }
        genre.removeLast()
        return genre
    }
    
    func getRelesedYear() -> String {
        return String(releasedDate.prefix(4))
    }
}
