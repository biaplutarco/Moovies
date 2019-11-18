//
//  MoviesCellViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    private var movie: Movie
    private var favoriteMoviesID = FavoriteMovie.all().map { Int($0.id) }
   
    var title: String
    var posterPath: String?
    var reloadState: (() -> Void)?
    var isFavorited: Bool {
        didSet {
            reloadState?()
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isFavorited = favoriteMoviesID.contains(movie.id)
    }
}

