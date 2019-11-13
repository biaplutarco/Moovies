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
    
    private var favoriteMovies = FavoriteMovie.all()
    
    var needReload: (() -> Void)?
    
    var overview: String
    var posterPath: String?
    var title: String
    var id: Int
    
    init(movie: Movie? = nil) {
        self.overview = movie?.overview ?? ""
        self.posterPath = movie?.posterPath
        self.title = movie?.title ?? ""
        self.id = movie?.id ?? 0
    }
    
    private func createFavoriteMovie() -> FavoriteMovie {
        let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
        favoriteMovie.id = Int32(id)
        favoriteMovie.posterPath = posterPath
        favoriteMovie.title = title
        favoriteMovie.overview = overview
        return favoriteMovie
    }
    
    func setFavoriteMovie(_ bool: Bool) {
        defaults.set(bool, forKey: "\(id)")
        let newFavoriteMovie = createFavoriteMovie()
        var favoritedIds = [Int]()
        
        favoriteMovies.forEach { favoritedMovie in
            favoritedIds.append(Int(favoritedMovie.id))
        }
            
        if favoritedIds.contains(id) {
            favoriteMovies.forEach { (favoritedMovie) in
                if favoritedMovie.id == Int32(id) {
                    favoritedMovie.destroy()
                    updateFavoritedMovies()
                } else {
                    newFavoriteMovie.save()
                }
            }
        }
    }
    
    func updateFavoritedMovies() {
        favoriteMovies = FavoriteMovie.all()
    }
    
    func isFavoriteMovie() -> Bool {
        return defaults.bool(forKey: "\(id)")
    }
}

extension MovieCellViewModel: CellViewModeling {
    
}
