//
//  MoviesControllerViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesControllerViewModel {
    
    var collectionViewCell: UICollectionViewCell.Type
    
    var needReload: (() -> Void)?
    
    var title: String = "Movies"
    
    private var movies: [Movie] = []
    
    init(collectionViewCell: UICollectionViewCell.Type) {
        self.collectionViewCell = collectionViewCell
        getResults()
    }
}

extension MoviesControllerViewModel: ControllerViewModeling {
    func getSizeOfItemsTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func getCellViewModelTo(indexPath: IndexPath) -> CellViewModeling {
        return MovieCellViewModel(movie: movies[indexPath.row])
    }
    
    func getResults() {
        let url = APIManager.shared.getURLMoviesFromGenres("28%2C12")
        APIManager.shared.get(url: url, type: Result.self) { [weak self] result in
            guard let result = result else { return }
            self?.movies.append(contentsOf: result.movies)
            self?.needReload?()
        }
    }
    
    func getNumberOfItems() -> Int {
        return movies.count

    }
}
