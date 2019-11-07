//
//  Result.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

struct Result: Codable {
    var movies: [Movie]
    var page: Int
    var dates: Dates
    
    enum CodingKeys: String, CodingKey {
        case page, dates
        case movies = "results"
    }
}

