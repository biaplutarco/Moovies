//
//  AplicationCoordinator.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class AplicationCoordinator: Coordinator {
    lazy var navigationController = UINavigationController(rootViewController: self.rootViewController)
    
    lazy var rootViewController: CollectionViewController = {
        let genreViewModel = GenreViewModel()
        genreViewModel.delegate = self
        let genreViewController = CollectionViewController(viewModel: genreViewModel)
        genreViewController.delegate = self
        return genreViewController
    }()

    func start() {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension AplicationCoordinator: CollectionViewModelDelegate {
    func didSelectedGenre(_ genre: Genre) {
        let movieViewModel = MovieViewModel(genre: genre)
        movieViewModel.delegate = self
        let movieViewController = CollectionViewController(viewModel: movieViewModel)
        movieViewController.delegate = self
        self.navigationController.pushViewController(movieViewController, animated: true)
    }
}

extension AplicationCoordinator: CollectionViewControllerDelegate {
    func didTappedFavorites() {
        let favoriteViewModel = FavoriteViewModel()
        let favoriteViewController = CollectionViewController(viewModel: favoriteViewModel)
        favoriteViewController.delegate = self
        self.navigationController.present(favoriteViewController, animated: true, completion: nil)
    }
}
