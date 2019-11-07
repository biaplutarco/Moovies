//
//  ViewController.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    lazy var movies: [Movie] = {
        var movies = [Movie]()
        APIManager.shared.getUpComingMovies { result in
            guard let result = result else { return }
            movies = result.movies
        }
        return movies
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
