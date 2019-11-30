//
//  ISessionUC.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ISessionUC {
    
    func getToken(completionHandler: @escaping (JSON?, NetworkError) -> ())
    
    func authenticate(username : String, password : String, completionHandler: @escaping (JSON?, NetworkError) -> ())
}
