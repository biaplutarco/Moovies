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
        
    var needReload: (() -> Void)?
    
    var posterPath: String?
    var title: String
    
    init(movie: Movie) {
        self.posterPath = movie.posterPath
        self.title = movie.title
    }
}

