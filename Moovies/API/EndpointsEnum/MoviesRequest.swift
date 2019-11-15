//
//  MoviesRequest.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

enum MoviesRequest {
    case get(genreID: Int)
    
    private func endpoint() -> String {
        let base = "https://api.themoviedb.org/3"
        let discoverMovies = "/discover/movie?"
        let key = "api_key=aa1f9a8cb654fe5383704dd771b128f0"
        let ptBR = "&language=pt-BR"
        let sortByPopularity = "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        let genre = "&with_genres="
        
        switch self {
        case .get(let genreID):
           return "\(base)\(discoverMovies)\(key)\(ptBR)\(sortByPopularity)\(genre)\(genreID)"
        }
    }
    
    private var url: URL {
      switch self {
      case .get(_):
        return URL(string: self.endpoint())!
        }
    }
    
    private var httpMethod: String {
      get {
        return "GET"
      }
    }
    
    var request: URLRequest {
      get {
        var getRequest = URLRequest(url: self.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = self.httpMethod
        return getRequest
      }
    }
}
