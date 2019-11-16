//
//  GenresViewDelegate.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol SectionViewDelegate {
    func didSelectedGenre(_ genre: Genre)
    func unFavoriteMovie(_ favoriteMovie: FavoriteMovie)
    func favoriteMovie(_ movie: Movie)
}
