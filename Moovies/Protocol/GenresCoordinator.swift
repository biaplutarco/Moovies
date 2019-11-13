//
//  GenresCoordinator.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenresCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let genresViewModel = GenresControllerViewModel()
        let genresViewController = ViewController(viewModel: genresViewModel, OfType: .genre)
        navigationController.pushViewController(genresViewController, animated: true)
    }
    
    func selectedGenre(genre: Genre) {
        let moviesViewModel = MoviesControllerViewModel(genre: genre)
        let moviesViewController = ViewController(viewModel: moviesViewModel, OfType: .movie)
        navigationController.pushViewController(moviesViewController, animated: true)
    }
    
    func selectedFavorites() {
        let favoriteViewModel = FavoriteControllerViewModel()
        let favoriteViewController = ViewController(viewModel: favoriteViewModel, OfType: .movie)
        navigationController.present(favoriteViewController, animated: true, completion: nil)
    }
}
