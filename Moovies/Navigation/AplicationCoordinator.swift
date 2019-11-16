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
        let viewModel = FavoriteViewModel(delegate: self)
        let viewController = FavoriteViewController(viewModel: viewModel, title: "Filmes Favoritos")
        return viewController
    }()
    
    lazy var searchMovieViewController: SearchMovieViewController = {
        let viewController = SearchMovieViewController()
        return viewController
    }()

    func start() {
        let window = UIApplication.shared.delegate?.window!
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}

extension AplicationCoordinator: FavoriteViewDelegate {
    func didTappedSearchButton() {
        self.navigationController.present(searchMovieViewController, animated: true, completion: nil)
    }
}

extension AplicationCoordinator: SearchMovieViewDelegate {
    func didTappedSaveButton() {
        self.searchMovieViewController.dismiss(animated: true) {
            self.rootViewController.favoriteView.collectionView.reloadData()
        }
    }
}
