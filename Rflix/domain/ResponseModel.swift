//
//  ResponseModel.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/20/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation

protocol ResponseModel {
    func success(r : Any)
    
    func failure(e : Error)
}
