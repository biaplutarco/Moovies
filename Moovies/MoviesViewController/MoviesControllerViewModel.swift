//
//  MoviesControllerViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesControllerViewModel {
    
    var needReload: (() -> Void)?
    
    private var movies: [Movie] = []
    
    init() {
        getMovies()
    }
    
    func getNumberOfItems() -> Int {
        return movies.count
    }
    
    func getMovies() {
        APIManager.shared.getUpComingMovies { [weak self] result in
            guard let result = result else { return }
            self?.movies.append(contentsOf: result.movies)
            self?.needReload?()
        }
    }
    
    func getMovieCellViewModelTo(indexPath: IndexPath) -> MoviesCellViewModel {
        return MoviesCellViewModel(movie: movies[indexPath.row])
    }
}
