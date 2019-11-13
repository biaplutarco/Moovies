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
        let genreViewModel = GenreViewModel(coordinator: self)
        let genreViewController = CollectionViewController(viewModel: genreViewModel)
        return genreViewController
    }()

    func start() {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func didSelected(genre: Genre) {
        let movieViewModel = MovieViewModel(genre: genre, coordinator: self)
        let movieViewController = CollectionViewController(viewModel: movieViewModel)
        self.navigationController.pushViewController(movieViewController, animated: true)
    }
}
