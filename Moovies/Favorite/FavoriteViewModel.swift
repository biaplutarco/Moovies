//
//  FavoriteViewModel.swift
//  Moovies
//
//  Created by aluno on 13/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

    //  Fazer:
    //  Trata o error caso não seja um Favorite Movie ou pelo menos corrigir a mensagem do fatal error

class FavoriteViewModel: CollectionViewModeling {
    var delegate: CollectionViewModelDelegate?
    
    var title: String = "Filmes Favoritos"
    
    var buttonTitle: String = "Buscar filmes"
        
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
        return CGSize(width: collectionView.frame.width/4, height: 200)
    }
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.row] as? FavoriteMovie,
            let cell = collectionView.cellForItem(at: indexPath) as? MovieCell else { return }
        
        FavoriteMovie.all().forEach { (favoritedMovie) in
            if favoritedMovie == movie {
                favoritedMovie.destroy()
                collectionView.reloadData()
                cell.viewModel.changeStateOf(button: cell.favoriteButton, to: false)
            }
        }
        
        cell.isSelected = true
    }
}
