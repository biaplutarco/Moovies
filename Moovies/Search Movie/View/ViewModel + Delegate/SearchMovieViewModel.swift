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
    
    var delegate: SearchMovieViewDelegate?
    
    var buttonTitle: String = "Salvar nos favoritos"
    
    var newFavoriteMovies: [Movie] = []
    
    var newUnFavoriteMovies: [Movie] = []
    
    init(delegate: SearchMovieViewDelegate? = nil) {
        self.delegate = delegate
    }
    
    //  Pega os filmes que ja estao no CoreData
    private func getFavoriteMovies() -> [FavoriteMovie] {
        return FavoriteMovie.all()
    }
    
    //  Checa se um Movie ja esta no CoreData
    private func checkInFavorites(movie: Movie) -> Bool {
        let favoriteIds = getFavoriteMovies().map { (favoriteMovie) -> Int in
            return Int(favoriteMovie.id)
        }
        
        if favoriteIds.contains(movie.id) {
            return true
        } else {
            return false
        }
    }
    
    //  Checa se um Movie esta selectionado como um novo favorite movie
    private func checkInNewFavoriteMovies(_ movie: Movie) -> Bool {
        newFavoriteMovies.contains { (favoriteMovie) -> Bool in
            if favoriteMovie == movie {
                return true
            } else {
                return false
            }
        }
    }
    
    func favorite(movie: Movie) {
        newFavoriteMovies.append(movie)
    }
    
    //  Desfavorite um novo favorite movie
    func unFavorite(movie: Movie) {
        if checkInNewFavoriteMovies(movie) == true {
            if let index = newFavoriteMovies.firstIndex(of: movie) {
                newFavoriteMovies.remove(at: index)
                newUnFavoriteMovies.append(movie)
            }
        } else {
            newUnFavoriteMovies.append(movie)
        }
    }
    
    //  Melhorar isso ta bem feio
    //  Remove um filme do CoreData
    private func removeFromFavorite() {
        let favorite = getFavoriteMovies()
        
        newUnFavoriteMovies.forEach { (movie) in
            favorite.forEach { (favoriteMovie) in
                if favoriteMovie.id == movie.id {
                    favoriteMovie.destroy()
                    unFavorite(movie: movie)
                }
            }
        }
    }
    
    // Add um filme no CoreData
    private func addToFavorite() {
        newFavoriteMovies.forEach { (movie) in
            let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
            favoriteMovie.id = Int32(movie.id)
            favoriteMovie.overview = movie.overview
            favoriteMovie.posterPath = movie.posterPath
            favoriteMovie.title = movie.title
            favoriteMovie.save()
        }
        newFavoriteMovies.removeAll()
    }
    
    private func cleanArrays() {
        newFavoriteMovies.removeAll()
        newUnFavoriteMovies.removeAll()
    }
    
    //  Chama as funçoes de add e remove
    func saveFavorites() {
        addToFavorite()
        removeFromFavorite()
        cleanArrays()
    }
    
    //  Checa se o filme ja é um favorito
    //  E chama as funçoes
    func isMovieAlreadyFavorite(_ movie: Movie) -> Bool {
        newFavoriteMovies.contains(where: { (favoriteMovie) -> Bool in
            if favoriteMovie.id == movie.id {
                return true
            } else {
                return false
            }
        })
    }
}