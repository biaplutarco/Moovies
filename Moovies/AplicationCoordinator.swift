//
//  AplicationCoordinator.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class AplicationCoordinator: Coordinator {
    var data: Any?
    
    var navigationController: UINavigationController
    
    lazy var rootViewController: CollectionViewController = {
        let genreViewModel = GenreViewModel()
        let genreViewController = CollectionViewController(viewModel: genreViewModel)
        return genreViewController
    }()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func didSelectedItem() {
        if let genre = data as? Genre {
            let movieViewModel = MovieViewModel(genre: genre)
            let movieViewController = CollectionViewController(viewModel: movieViewModel)
            
            DispatchQueue.main.async {
                self.navigationController.pushViewController(movieViewController, animated: true)
                
            }
            
            
            print(movieViewController)
        }
    }
}
