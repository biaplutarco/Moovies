//
//  CollectionViewModelDelegate.swift
//  Moovies
//
//  Created by aluno on 13/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol CollectionViewModelDelegate: class {
    func didSelectedGenre(_ genre: Genre)
}

protocol CollectionViewControllerDelegate: class {
    func didTappedFavorites()
}
