//
//  SearchMovieViewModel.swift
//  Moovies
//
//  Created by aluno on 16/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class SearchMovieViewModel {
    var title: String = "Buscar Filmes"
    
    var buttonTitle: String = "Salvar nos favoritos"
    
    var newFavoriteMovies: [Movie] = []
    
    var newUnFavoriteMovies: [FavoriteMovie] = []
    
    private func favoriteMovies() {
        newFavoriteMovies.forEach { (movie) in
            let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
            favoriteMovie.id = Int32(movie.id)
            favoriteMovie.overview = movie.overview
            favoriteMovie.posterPath = movie.posterPath
            favoriteMovie.title = movie.title
            favoriteMovie.save()
        }
    }
    
    private func unFavoriteMovies() {
        newUnFavoriteMovies.forEach { (favoriteMovie) in
            favoriteMovie.destroy()
        }
    }
    
    func saveFavorites() {
        unFavoriteMovies()
        favoriteMovies()
    }
}
