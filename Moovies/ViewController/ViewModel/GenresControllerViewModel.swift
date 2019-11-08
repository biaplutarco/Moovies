//
//  GenresControllerViewModel.swift
//  Moovies
//
//  Created by aluno on 07/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenresControllerViewModel {
        
    var needReload: (() -> Void)?
    
    var title: String = "Genres"
    
    private var genres: [Genre] = []

    init() {
        getResults()
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> Genre {
        return genres[indexPath.row]
    }
}

extension GenresControllerViewModel: ControllerViewModeling {
    func getSizeOfItemsTo(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    func getCellViewModelTo(indexPath: IndexPath) -> CellViewModeling {
        return GenreCellViewModel(genre: genres[indexPath.row])
    }
    
    func getResults() {
        let url = APIManager.shared.getURLGenres()
        APIManager.shared.get(url: url, type: Genres.self) { [weak self] result in
            guard let result = result else { return }
            self?.genres.append(contentsOf: result.genres)
            self?.needReload?()
        }
    }
    
    func getNumberOfItems() -> Int {
        return genres.count
    }
    
}
