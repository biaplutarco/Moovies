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
    
    private let totalPages = 18
    private let baseURL = "https://api.themoviedb.org/3"
    private let getUpComingMoviesEndPoint = "/movie/upcoming?api_key=aa1f9a8cb654fe5383704dd771b128f0"
    private let getInPTBR = "&language=pt-BR"
    
    func getUpComingMovies(completion: @escaping (Result?) -> Void) {
        for i in 1...totalPages {
            let rawURL = "\(baseURL)\(getUpComingMoviesEndPoint)\(getInPTBR)&page=\(i)"
            guard let url = URL(string: rawURL) else { fatalError("can't get the request") }
            
            var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            getRequest.httpMethod = "GET"
            
            let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
                
                if error != nil {
                    print("GET Request in \(getRequest)")
                    print("Error: \(error!)")
                }
                
                if data != nil {
                    do {
                        let resultObject = try JSONDecoder().decode(Result.self, from: data!)
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
}
