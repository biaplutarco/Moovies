//
//  MovieViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class MoviesViewModel: SectionViewModeling {
    var title: String = "Filmes"
    
    var data: [Any] = []
    
    var reloadData: (() -> Void)?
    
    private var genreID: Int
    
    var allFavorites = FavoriteMovie.all()
    
    init(genre: Genre) {
        self.genreID = genre.id
        getData()
    }
    
    private func checkFavorite(movie: Movie) -> Bool {
        let favoriteIds = allFavorites.map { (favoriteMovie) -> Int in
            return Int(favoriteMovie.id)
        }
        
        return favoriteIds.contains(movie.id)
    }
    
    private func getData() {
        APIManager.shared.getMoviesFromGenre(id: genreID) { (movies) in
            if let movies = movies {
                self.data.append(contentsOf: movies.movies)
                self.reloadData?()
            } else {
                let movieEmpty = Movie(id: 0, title: "loading", overview: "", posterPath: nil)
                self.data.append(movieEmpty)
                self.reloadData?()
            }
        }
    }
}
