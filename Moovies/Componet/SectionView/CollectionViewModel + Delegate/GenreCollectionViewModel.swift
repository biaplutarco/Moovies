//
//  GenreCollectionViewModel.swift
//  Moovies
//
//  Created by aluno on 17/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenreCollectionViewModel: CollectionViewModeling {
    var delegate: CollectionViewModelDelegate?
    
    var data: [Any] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var numberOfItems: Int = 0
    
    var itemSize: CGSize = CGSize(width: 140, height: 36)
    
    init(data: [Any], delegate: CollectionViewModelDelegate? = nil) {
        self.data = data
        self.delegate = delegate
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
    
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath) {
        guard let genre = data[indexPath.row] as? Genre,
            let delegate = delegate as? GenreCollectionViewModelDelegate else { fatalError("error casting")}
        delegate.didSelectedGenre(genre)
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        return flowLayout
    }
}
