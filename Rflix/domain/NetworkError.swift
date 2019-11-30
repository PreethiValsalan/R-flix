//
//  NetworkError.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case sessionNotAvailable
    case dataNotAvailablw
    case failure
    case success
}
