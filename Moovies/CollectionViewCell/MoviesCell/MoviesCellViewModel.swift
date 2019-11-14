//
//  MoviesCellViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    private let userDefaults = UserDefaults.standard

    var posterPath: String?
    var title: String
    
    init(movie: Movie) {
        self.posterPath = movie.posterPath
        self.title = movie.title
    }
    
    func changeStateOf(button: UIButton) {
        button.isSelected.toggle()
        
        if button.isSelected == true {
            userDefaults.set(true, forKey: title)
        } else {
            userDefaults.set(false, forKey: title)
        }
    }
    
    func getStateOf(button: UIButton) -> Bool {
        return userDefaults.bool(forKey: title)
    }
}

