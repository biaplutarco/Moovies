//
//  GenreViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenresViewModel: SectionViewModeling {
    var delegate: SectionViewDelegate?

    var title: String = "Gêneros"
    
    var numberOfItems: Int = 0
    
    var data: [Any] = [] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    init(delegate: SectionViewDelegate? = nil) {
        self.delegate = delegate
    }
    
    func getData() {
        APIManager.shared.getGenres { (genres) in
            if let genres = genres {
                self.data.append(contentsOf: genres.genres)
                self.reloadData?()
            } else {
                let genreEmpty = Genre(id: 0, name: "loading")
                self.data.append(genreEmpty)
                self.reloadData?()
            }
        }
    }
    
    func registerCellTo(collectionView: UICollectionView) {
        collectionView.registerCell(of: GenreCell.self)
    }
    
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: GenreCell.self, forIndexPath: indexPath)
        
        if let genre = data[indexPath.row] as? Genre {
            cell.viewModel = GenreCellViewModel(genre: genre)
        }
        
        return cell
    }
    
    func getItemSizeTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: 140, height: 36)
    }
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        if let genre = data[indexPath.row] as? Genre {
            delegate?.didSelectedGenre(genre)
        }
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        return flowLayout
    }
}
