//
//  GenreViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class GenresViewModel: SectionViewModeling {
    var title: String = "Gêneros"
    
    var data: [Any] = []
    
    var reloadData: (() -> Void)?
    
    init() {
        getData()
    }
   
    private func getData() {
        APIManager.shared.getGenres { (genres) in
            if let genres = genres {
                self.data.append(contentsOf: genres.genres)
                self.reloadData?()
            } else {
                let genreEmpty = Genre(id: 0, name: "loading")
                self.data.append(genreEmpty)
                self.reloadData?()
            }
        }
    }
}
