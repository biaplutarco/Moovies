//
//  GenreCollectionViewModel.swift
//  Moovies
//
//  Created by aluno on 17/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieCollectionViewModel: CollectionViewModeling {
    var delegate: CollectionViewModelDelegate?
    
    var data: [Any] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var numberOfItems: Int = 0
    
    var itemSize: CGSize = CGSize(width: 160, height: 220)
    
    init(data: [Any], delegate: CollectionViewModelDelegate? = nil) {
        self.data = data
        self.delegate = delegate
    }
    
    func registerCellTo(collectionView: UICollectionView) {
        collectionView.registerCell(of: MovieCell.self)
    }
    
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: MovieCell.self, forIndexPath: indexPath)
        
        if let movie = data[indexPath.row] as? Movie {
            cell.viewModel = MovieCellViewModel(movie: movie)
        }
        
        return cell
    }
    
    func getItemSizeTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.2, height: 60)
    }
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.row] as? Movie,
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCell,
            let delegate = delegate as? MovieCollectionViewModelDelegate else { fatalError("error casting") }
        
        if delegate.isMovieAlreadyFavorite(movie) == true {
            delegate.unFavorite(movie: movie)
            cell.viewModel.isFavorited = false
        } else {
            delegate.favorite(movie: movie)
            cell.viewModel.isFavorited = true
        }
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        return flowLayout
    }
}
