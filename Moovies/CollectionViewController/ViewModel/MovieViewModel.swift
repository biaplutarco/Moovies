//
//  MovieViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

    //  Fazer:
    //  Tentar quebrar melhor a didSelect function, ta muito grande

class MovieViewModel: CollectionViewModeling {
    var delegate: CollectionViewModelDelegate?
    
    var title: String
        
    var numberOfItems: Int = 0
    
    var data: [Any] = [] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    private var genreID: Int
    
    init(genre: Genre, delegate: CollectionViewModelDelegate? = nil) {
        self.title = genre.name
        self.genreID = genre.id
        self.delegate = delegate
    }
    
    func getData() {
        let url = APIManager.shared.getURLMoviesFromGenres("\(genreID)")
        APIManager.shared.get(url: url, type: Movies.self) { [weak self] result in
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
    
    //  O que essa função ta fazendo?
    //  Fetch
    //  Checagem de favoritos
    //  Criação de Favorite Movie
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.row] as? Movie,
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCell else { return }
        
        var ids = [Int]()
        
        FavoriteMovie.all().forEach({ ids.append(Int($0.id)) })
        
        if ids.contains(movie.id) {
            FavoriteMovie.all().forEach { (favoritedMovie) in
                if Int(favoritedMovie.id) == movie.id {
                    favoritedMovie.destroy()
                    cell.viewModel.changeStateOf(button: cell.favoriteButton, to: false)
                }
            }
        } else {
            let newFavoritedMovie = FavoriteMovie(context: FavoriteMovie.context)
            newFavoritedMovie.id = Int32(movie.id)
            newFavoritedMovie.overview = movie.overview
            newFavoritedMovie.posterPath = movie.posterPath
            newFavoritedMovie.title = movie.title
            newFavoritedMovie.save()
            cell.viewModel.changeStateOf(button: cell.favoriteButton, to: true)
        }
    }
}
