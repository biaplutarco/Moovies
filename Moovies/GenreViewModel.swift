//
//  GenreViewModel.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenreViewModel: CollectionViewModeling {
    
    var title: String = "Gêneros"
    
    var numberOfItems: Int = 0
    
    var data: [Any] = [] {
        didSet {
            numberOfItems = data.count
        }
    }
    
    var reloadData: (() -> Void)?
    
    func getData() {
        let url = APIManager.shared.getURLGenres()
        APIManager.shared.get(url: url, type: Genres.self) { [weak self] result in
            guard let result = result else { return }
            self?.data.append(contentsOf: result.genres)
            self?.reloadData?()
        }
    }
    
    func registerCellTo(collectionView: UICollectionView) {
        collectionView.registerCell(of: GenreCell.self)
    }
    
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(of: Genre.self, forIndexPath: indexPath)
    }
    
    func getCellViewModelTo(indexPath: IndexPath) {
        <#code#>
    }
    
    func getItemSizeTo(collectionView: UICollectionView) {
        <#code#>
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        <#code#>
    }
    
    
}
