//
//  MovieViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesViewModel: SectionViewModeling {
    var delegate: SectionViewDelegate?

    var title: String = "Filmes"
        
    var numberOfItems: Int = 0
    
    var data: [Any] = [] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    private var genreID: Int
    
    init(genre: Genre) {
        self.genreID = genre.id
    }
    
//    private func createFavoriteMovie(from movie: Movie) {
//        let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
//        favoriteMovie.id = Int32(movie.id)
//        favoriteMovie.overview = movie.overview
//        favoriteMovie.posterPath = movie.posterPath
//        favoriteMovie.title = movie.title
//        favoriteMovie.save()
//    }
//
    private func getFavoriteMovies() -> [FavoriteMovie] {
        return FavoriteMovie.all()
    }
    
    private func checkFavorite(movie: Movie) -> Bool {
        let favoriteIds = getFavoriteMovies().map { (favoriteMovie) -> Int in
            return Int(favoriteMovie.id)
        }
        
        if favoriteIds.contains(movie.id) {
            return true
        } else {
            return false
        }
    }
    
    func getData() {
        APIManager.shared.getMoviesFromGenre(id: genreID) { (movies) in
            if let movies = movies {
                self.data.append(contentsOf: movies.movies)
                self.reloadData?()
            } else {
                let movieEmpty = Movie(id: 0, title: "loading", overview: "", posterPath: nil)
                self.data.append(movieEmpty)
                self.reloadData?()
            }
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
        return CGSize(width: collectionView.frame.width/2.2, height: 60)
    }
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.row] as? Movie,
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCell else { return }
        
        if checkFavorite(movie: movie) == true {
            getFavoriteMovies().forEach { (favoritedMovie) in
                if favoritedMovie.id == movie.id {
//                    favoritedMovie.destroy()
                    delegate?.unFavoriteMovie(favoritedMovie)
                    cell.viewModel.changeStateOf(button: cell.favoriteButton, to: false)
                }
            }
        } else {
//            createFavoriteMovie(from: movie)
            delegate?.favoriteMovie(movie)
            cell.viewModel.changeStateOf(button: cell.favoriteButton, to: false)
        }
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        return flowLayout
    }
    
}
