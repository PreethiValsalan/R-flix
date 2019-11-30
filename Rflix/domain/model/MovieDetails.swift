//
//  MovieDetails.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetails {
    private(set) var poster : String?
    private(set) var title = ""
    private(set) var id : Int
    private(set) var releasedDate = ""
    private(set) var summary = ""
    private(set) var runtime : Int
    private(set) var studio = ""
    private(set) var homePage : String?
    private(set) var imdbId : String?
    private(set) var castArray : NSMutableArray
    private(set) var recomendationsArray : NSMutableArray
    private(set) var director = ""
 //   private(set) var genreIds : [JSON];
    
    /*
     A movie’s card should dis-
     play the following: its poster (image), title, year of release, genre(s),
     
     and your TMDb rating for this movie, if you’ve rated it, or its global
     TMDb rating otherwise (see Rate Movies below).
     A movie’s detailed view should display all the fields
     that are displayed on its card, in addition to the following: links
     to its homepage and IMDb page (should open in a Web view), its
     plot summary, running time, cast (actors), director(s), production
     studio(s), and its TMDb user reviews (at most 5, if any).
     
     http://www.imdb.com/title/tt0108160/
     
     
     {
     "adult": false,
     "backdrop_path": "/pVGzV02qmHVoKx9ehBNy7m2u5fs.jpg",
     "belongs_to_collection": null,
     "budget": 13200000,
     "genres": [
     {
     "id": 35,
     "name": "Comedy"
     },
     {
     "id": 18,
     "name": "Drama"
     },
     {
     "id": 10749,
     "name": "Romance"
     }
     ],
     "homepage": null,
     "id": 19404,
     "imdb_id": "tt0112870",
     "original_language": "hi",
     "original_title": "दिलवाले दुल्हनिया ले जायेंगे",
     "overview": "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
     "popularity": 16.359,
     "poster_path": "/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
     "production_companies": [
     {
     "id": 1569,
     "logo_path": "/lvzN86o3jrP44DIvn4SMBLOl9PF.png",
     "name": "Yash Raj Films",
     "origin_country": "IN"
     }
     ],
     "production_countries": [
     {
     "iso_3166_1": "IN",
     "name": "India"
     }
     ],
     "release_date": "1995-10-20",
     "revenue": 100000000,
     "runtime": 190,
     "spoken_languages": [
     {
     "iso_639_1": "hi",
     "name": "हिन्दी"
     }
     ],
     "status": "Released",
     "tagline": "Come Fall In love, All Over Again..",
     "title": "Dilwale Dulhania Le Jayenge",
     "video": false,
     "vote_average": 8.9,
     "vote_count": 2153
     }
     */
    
    init(json : JSON) {
        id = json["id"].int!
        poster = json["poster_path"].string!
        title = json["original_title"].string!
        releasedDate = json["release_date"].string!
   //     genreIds = json["genre_ids"].array!
        summary = json["overview"].string!
        runtime = json["runtime"].int!

        if let productionCompanies = json["production_companies"].array {
            if(productionCompanies.count > 0) {
                let company = productionCompanies[0] as JSON
                studio = company["name"].string!
            }
        }

        if let link = json["imdb_id"].string {
            self.imdbId = link
        }

        if let link = json["homepage"].string {
            self.homePage = link
        }
        let credits = json["credits"]
        let castsJson = credits["cast"].array!
        castArray = NSMutableArray(capacity: (castsJson.count))
        for castJson in castsJson {
            castArray.add(CastModel(json: castJson))
        }
        let crewJsonArr = credits["crew"].array!
        for crewJson in crewJsonArr {
            let job = crewJson["job"].string!
            if(job == "Director") {
                self.director = crewJson["name"].string!
            }
        }
        let recommendations = json["recommendations"]
        let recommendationsJson = recommendations["results"].array!
        recomendationsArray = NSMutableArray(capacity: (recommendationsJson.count))
        for movieJson in recommendationsJson {
            recomendationsArray.add(MovieModel(json: movieJson))
        }
    }
    
    func getCastCount() -> Int {
        return castArray.count
    }
    
    func getMovieCast(index : Int) -> CastModel {
        return castArray.object(at: index) as! CastModel
    }
    
    func getMovieRecommendations() -> Int {
        return recomendationsArray.count
    }
    
    func getMovieRecommendation(index : Int) -> MovieModel {
        return recomendationsArray.object(at: index) as! MovieModel
    }
}
