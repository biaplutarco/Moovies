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
    var realeseDate: String
    
    init(movie: Movie) {
        self.posterPath = movie.posterPath
        self.realeseDate = movie.releaseDate
    }
}

extension MovieCellViewModel: CellViewModeling {
    
}
