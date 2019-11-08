//
//  FavoriteControllerViewModel.swift
//  Moovies
//
//  Created by aluno on 08/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class FavoriteControllerViewModel {
        
    var needReload: (() -> Void)?
    
    var title: String = "Favorite Movies"
    
    private var favoriteMovies: [FavoriteMovie] = []
    
    init() {
        getFavoriteMovies()
    }
}

extension FavoriteControllerViewModel: ControllerViewModeling {
    func getSizeOfItemsTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: 180, height: 320)
    }
    
    func getCellViewModelTo(indexPath: IndexPath) -> CellViewModeling {
        let favoriteMovie = favoriteMovies[indexPath.row]
        guard let title = favoriteMovie.title, let overview = favoriteMovie.overview else {
            fatalError("can't get movie from coredata")
        }
        
        let movie = Movie(id: Int(favoriteMovie.id), title: title,
                          overview: overview, posterPath: favoriteMovie.posterPath)
        
        return MovieCellViewModel(movie: movie)
    }
    
    func getFavoriteMovies() {
        favoriteMovies = FavoriteMovie.all()
    }
    
    func getNumberOfItems() -> Int {
        return favoriteMovies.count

    }
}
