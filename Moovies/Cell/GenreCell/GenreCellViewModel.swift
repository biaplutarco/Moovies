//
//  GenreCellViewModel.swift
//  Moovies
//
//  Created by aluno on 07/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenreCellViewModel {
    var id: String?
    var name: String
    
    init(genre: Genre) {
        self.id = "\(genre.id)"
        self.name = genre.name
    }
}

