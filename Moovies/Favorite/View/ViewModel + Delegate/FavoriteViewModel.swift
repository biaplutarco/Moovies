//
//  FavoriteViewModel.swift
//  Moovies
//
//  Created by aluno on 13/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import CoreGraphics

    //  Fazer:
    //  Trata o error caso não seja um Favorite Movie ou pelo menos corrigir a mensagem do fatal error

class FavoriteViewModel {
    weak var delegate: FavoriteViewDelegate?

    var buttonTitle: String = "Buscar filmes"
    
    var isEmptyMessage: String = "Você não tem filmes favoritados ainda. Adicione algum!"
    
    var isEmpty: Bool = true
        
    var numberOfItems: Int = 0
    
    var itemSize: CGSize = CGSize(width: 160, height: 220)
    
    var movies = [Movie]() {
        didSet {
            numberOfItems = movies.count
            isEmpty = movies.isEmpty
            reloadData?()
        }
    }
    
    var reloadData: (() -> Void)?
    
    init(delegate: FavoriteViewDelegate? = nil) {
        self.delegate = delegate
        getData()
    }
    
    func createMovie(from favoriteMovie: FavoriteMovie) -> Movie? {
        guard let title = favoriteMovie.title, let overview = favoriteMovie.overview else {
            return nil
        }
        let movie = Movie(id: Int(favoriteMovie.id),
                          title: title,
                          overview: overview,
                          posterPath: favoriteMovie.posterPath)
        return movie
    }
    
    func updateScreen() {
        getData()
    }
    
    private func getData() {
        let data = FavoriteMovie.all()
        movies = data.compactMap { createMovie(from: $0) }
    }
    
    func getMovieCellViewModel(of index: Int) -> MovieCellViewModel? {
        let viewModel = MovieCellViewModel(movie: movies[index])
        return viewModel
    }
    
    func removeFromFavorites(at index: Int) {
        let movie = movies[index]
        FavoriteMovie.destroy(movie)
        updateScreen()
    }
}
