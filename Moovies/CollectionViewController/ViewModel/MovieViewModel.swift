//
//  MovieViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieViewModel: CollectionViewModeling {
    var title: String
    
    var coordinator: AplicationCoordinator
    
    var numberOfItems: Int = 0
    
    var data: [Any] = [] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    private var genreID: Int
    
    init(genre: Genre, coordinator: AplicationCoordinator) {
        self.coordinator = coordinator
        self.title = genre.name
        self.genreID = genre.id
    }
    
    func getData() {
        let url = APIManager.shared.getURLMoviesFromGenres("\(genreID)")
        APIManager.shared.get(url: url, type: Result.self) { [weak self] result in
            guard let result = result else { return }
            self?.data.append(contentsOf: result.movies)
            self?.reloadData?()
        }
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
        return CGSize(width: collectionView.frame.width/2.2, height: 320)

    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
    }
}
