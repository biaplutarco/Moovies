//
//  GenreCellViewModel.swift
//  Moovies
//
//  Created by aluno on 07/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenreCellViewModel {
    var name: String
    
    init(genre: Genre) {
        self.name = genre.name
    }
}

