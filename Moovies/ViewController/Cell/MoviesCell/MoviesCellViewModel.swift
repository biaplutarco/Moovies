//
//  MoviesCellViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    let defaults = UserDefaults.standard
    
    private var favoriteMovie: FavoriteMovie
    
    var overview: String
    var posterPath: String?
    var title: String
    var id: Int
    
    init(movie: Movie) {
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.title = movie.title
        self.id = movie.id
        
        self.favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
        favoriteMovie.overview = overview
        favoriteMovie.posterPath = posterPath
        favoriteMovie.title = title
        favoriteMovie.id = Int32(id)
    }
    
    func setFavoriteMovie(_ bool: Bool) {
        defaults.set(bool, forKey: "\(id)")
        favoriteMovie.save()
    }
    
    func isFavoriteMovie() -> Bool {
        favoriteMovie.destroy()
        return defaults.bool(forKey: "\(id)")
    }
}

extension MovieCellViewModel: CellViewModeling {
    
}
