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
    //  Usar urlcomponents
    //  ohttp stamps - testar a requisição

    func getMoviesFromGenre(id: Int, completion: @escaping (Movies?) -> Void) {
        let moviesEnum: MoviesRequest = .get(genreID: id)
        
        get(request: moviesEnum.request, type: Movies.self) { result in
            completion(result)
        }
    }
    
    func getGenres(completion: @escaping (Genres?) -> Void) {
        let genreRequest: GenreRequest = .all
        
        get(request: genreRequest.request, type: Genres.self) { result in
            completion(result)
        }
    }
    
    private func get<T: Codable>(request: URLRequest, type: T.Type, completion: @escaping (T?) -> Void) {
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
