//
//  Movie.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

