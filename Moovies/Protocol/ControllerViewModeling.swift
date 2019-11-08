//
//  ControllerViewModeling.swift
//  Moovies
//
//  Created by aluno on 07/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

protocol ControllerViewModeling {
    var collectionViewCell: UICollectionViewCell.Type { get set }
    var needReload: (() -> Void)? { get set }
    var title: String { get }
    func getResults()
    func getNumberOfItems() -> Int
    func getSizeOfItemsTo(collectionView: UICollectionView) -> CGSize
    func getCellViewModelTo(indexPath: IndexPath) -> CellViewModeling
}
