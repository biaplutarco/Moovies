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
    var dates: Dates
    var page: Int
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, dates
        case movies = "results"
        case totalPages = "total_pages"
    }
}

