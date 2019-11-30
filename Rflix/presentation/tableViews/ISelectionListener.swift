//
//  ISelectionListener.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/24/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation

protocol ISelectionListener {
    func onSelect(movie : MovieModel)
    
    func loadMore()
}
