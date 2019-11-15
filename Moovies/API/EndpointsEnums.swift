//
//  EndpointsEnums.swift
//  Moovies
//
//  Created by aluno on 14/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

    //  Requisições que eu faço:
    //  Pego os generos
    //  Pego os filmes do genero
    //  Pego o poster dos filmes

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


enum GenreRequest {
    case all
    
    private func endpoint() -> String {
        let base = "https://api.themoviedb.org/3"
        let genres = "/genre/movie/list?"
        let key = "api_key=aa1f9a8cb654fe5383704dd771b128f0"
        let ptBR = "&language=pt-BR"
        
        switch self {
        case .all:
           return "\(base)\(genres)\(key)\(ptBR)"
        }
    }
    
    private var url: URL {
      switch self {
      case .all:
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
