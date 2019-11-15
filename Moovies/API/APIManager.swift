//
//  APIManager.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    static let shared = APIManager()
    
    //  Estudar para melhorias:
    //  Enum pra rotas
    //  Usar urlcomponents
    //  ohttp stamps - testar a requisição
    
    private let totalPages = 1
    private let baseURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=aa1f9a8cb654fe5383704dd771b128f0&language=pt-BR"
    private let key = "api_key=aa1f9a8cb654fe5383704dd771b128f0"
    private let getDicoverMovies = "/discover/movie?"
    private let getGenresEndPoint = "/genre/movie/list?"
    private let sortByPopularity = "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
    private let getFromGenres = "&with_genres="
    private let getInPTBR = "&language=pt-BR"
    
    func getURLMoviesFromGenres(_ genres: String) -> URL {
        let fromGenres = "\(getFromGenres)\(genres)"
        let rawURL = "\(baseURL)\(getDicoverMovies)\(key)\(getInPTBR)\(sortByPopularity)\(fromGenres)"
        guard let url = URL(string: rawURL) else { fatalError("can't get the request") }
        
        return url
    }
    
    func getMoviesFromGenre(id: Int) -> [Movie] {
        let moviesEnum: MoviesRequest = .get(genreID: id)
        var movies = [Movie]()
        
        get(request: moviesEnum.request, type: Movies.self) { result in
            guard let result = result else { return }
            movies.append(contentsOf: result.movies)
        }
        
        return movies
    }
    
    func getGenres(completion: @escaping (Genres?) -> Void) {
        let genreRequest: GenreRequest = .all
        
        get(request: genreRequest.request, type: Genres.self) { result in
            completion(result)
        }
    }
    
     func get<T: Codable>(request: URLRequest, type: T.Type, completion: @escaping (T?) -> Void) {
        let getTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("GET Request in \(request)")
                print("Error: \(error!)")
            }
            
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(type, from: data!)
                    completion(resultObject)
                    
                } catch let parserError {
                    DispatchQueue.main.async {
                        print(parserError)
                        print("Unable to parse JSON response in \(request)")
                    }
                }
            } else {
                print ("Received empty quest response from \(request)")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
}
