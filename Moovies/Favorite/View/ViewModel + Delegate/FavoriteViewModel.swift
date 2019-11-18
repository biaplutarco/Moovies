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
    
    var data: [Any] = FavoriteMovie.all() {
        didSet {
            numberOfItems = data.count
            isEmpty = data.isEmpty
        }
    }
    
    var reloadData: (() -> Void)?
    
    init(delegate: FavoriteViewDelegate? = nil) {
        self.delegate = delegate
        getData()
    }
    
    private func createMovie(from favoriteMovie: FavoriteMovie) -> Movie {
        let movie = Movie(id: Int(favoriteMovie.id),
                          title: favoriteMovie.title ?? "",
                          overview: favoriteMovie.overview ?? "",
                          posterPath: favoriteMovie.posterPath)
        return movie
    }
    
    private func getData() {
        data = FavoriteMovie.all()
        reloadData?()
    }
    
    func getMovieCellViewModel(of index: Int) -> MovieCellViewModel {
        guard let favoritedMovie = data[index] as? FavoriteMovie else { fatalError("isn't a favorite movie") }
        let movie = createMovie(from: favoritedMovie)
        let viewModel = MovieCellViewModel(movie: movie)
        return viewModel
    }
}
