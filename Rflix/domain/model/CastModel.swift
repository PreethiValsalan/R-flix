//
//  Cast.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/24/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

class CastModel {
  
    private (set) var id = 0
    private (set) var character = ""
    private (set) var name = ""
    private(set) var profilePic : String?
    
/*
     {
     "cast_id": 4,
     "character": "The Narrator",
     "credit_id": "52fe4250c3a36847f80149f3",
     "gender": 2,
     "id": 819,
     "name": "Edward Norton",
     "order": 0,
     "profile_path": "/eIkFHNlfretLS1spAcIoihKUS62.jpg"
     },
 */
    init(json : JSON) {
        id = json["cast_id"].int!
        if let pic = json["profile_path"].string {
            self.profilePic = pic
        }
        character = json["character"].string!
        name = json["name"].string!
    }
}
