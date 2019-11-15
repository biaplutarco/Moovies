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
    private let baseURL = "https://api.themoviedb.org/3"
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
    
    func getURLGenres() -> URL {
        let rawURL = "\(baseURL)\(getGenresEndPoint)\(key)\(getInPTBR)"
        guard let url = URL(string: rawURL) else { fatalError("can't get the request") }
        
        return url
    }
    
    func get<T: Codable>(url: URL, type: T.Type, completion: @escaping (T?) -> Void) {
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            
            if error != nil {
                print("GET Request in \(getRequest)")
                print("Error: \(error!)")
            }
            
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(type, from: data!)
                    completion(resultObject)
                    
                } catch let parserError {
                    DispatchQueue.main.async {
                        print(parserError)
                        print("Unable to parse JSON response in \(getRequest)")
                    }
                }
            } else {
                print ("Received empty quest response from \(getRequest)")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
}
