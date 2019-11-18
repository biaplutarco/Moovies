//
//  CollectionViewModelDelegate.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol CollectionViewModelDelegate {
}

protocol MovieCollectionViewModelDelegate: CollectionViewModelDelegate {
    func unFavorite(movie: Movie)
    func favorite(movie: Movie)
    func isMovieAlreadyFavorite(_ movie: Movie) -> Bool
}

protocol GenreCollectionViewModelDelegate: CollectionViewModelDelegate {
    func didSelectedGenre(_ genre: Genre)
}
