//
//  MoviePosterRequest.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

enum MoviePoster {
    case get(path: String)
    
    private func endpoint() -> String {
        let base = "https://image.tmdb.org/t/p/w500"
        
        switch self {
        case .get(let path):
           return "\(base)\(path)"
        }
    }
    
    var url: URL {
      switch self {
      case .get(_):
        return URL(string: self.endpoint())!
        }
    }
}
