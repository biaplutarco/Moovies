//
//  MoviesCellViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    var posterPath: String?
    var title: String
    var index: Int
    
    init(movie: Movie, index: Int) {
        self.posterPath = movie.posterPath
        self.title = movie.title
        self.index = index
    }
}

extension MovieCellViewModel: CellViewModeling {
    
}
