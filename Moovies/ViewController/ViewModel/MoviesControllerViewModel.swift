//
//  MoviesControllerViewModel.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesControllerViewModel {
        
    var needReload: (() -> Void)?
    
    var title: String
    
    var genreID: Int
    
    private var movies: [Movie] = []
    
    init(genre: Genre) {
        self.genreID = genre.id
        self.title = genre.name
        getResults()
    }
}

extension MoviesControllerViewModel: ControllerViewModeling {
    func getSizeOfItemsTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: 180, height: 320)
    }
    
    func getCellViewModelTo(indexPath: IndexPath) -> CellViewModeling {
        return MovieCellViewModel(movie: movies[indexPath.row], index: indexPath.row)
    }
    
    func getResults() {
        let url = APIManager.shared.getURLMoviesFromGenres("\(genreID)")
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
