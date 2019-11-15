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
    
    lazy var rootViewController: FavoriteViewController = {
        let viewModel = FavoriteControllerViewModel()
        let genreViewController = FavoriteViewController(viewModel: viewModel, delegate: self)
        return genreViewController
    }()

    func start() {
        let window = UIApplication.shared.delegate?.window!
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}

extension AplicationCoordinator: CollectionViewModelDelegate {
    func didSelectedGenre(_ genre: Genre) {
        let viewModel = MovieViewModel(genre: genre, delegate: self)
        let movieViewController = CollectionViewController(viewModel: viewModel, delegate: self)
        self.navigationController.pushViewController(movieViewController, animated: true)
    }
}

extension AplicationCoordinator: CollectionViewControllerDelegate {
    func didTappedFavorites() {
        let viewModel = FavoriteViewModel()
        let favoriteViewController = CollectionViewController(viewModel: viewModel, delegate: self)
        self.navigationController.present(favoriteViewController, animated: true, completion: nil)
    }
}
