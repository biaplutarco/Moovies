//
//  FavoriteViewModel.swift
//  Moovies
//
//  Created by aluno on 13/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class FavoriteViewModel: CollectionViewModeling {
    var delegate: CollectionViewModelDelegate?
    
    var title: String = "Filmes Favoritos"
        
    var numberOfItems: Int = 0
    
    var data: [Any] = FavoriteMovie.all() {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    func getData() {
        data = FavoriteMovie.all()
    }
    
    func registerCellTo(collectionView: UICollectionView) {
        collectionView.registerCell(of: MovieCell.self)
    }
    
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: MovieCell.self, forIndexPath: indexPath)
        
        guard let favoritedMovie = data[indexPath.row] as? FavoriteMovie else { fatalError("puts nao foi") }
        let movie = Movie(id: Int(favoritedMovie.id),
                          title: favoritedMovie.title ?? "",
                          overview: favoritedMovie.overview ?? "",
                          posterPath: favoritedMovie.posterPath)
        
        cell.viewModel = MovieCellViewModel(movie: movie)
        
        return cell
    }
    
    func getItemSizeTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: 100)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
    }
}
