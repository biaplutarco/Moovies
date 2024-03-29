//
//  CollectionViewModeling.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

protocol CollectionViewModeling {
    var numberOfItems: Int { get set }
    var itemSize: CGSize { get set }
    var data: [Any] { get set }
    
    func registerCellTo(collectionView: UICollectionView)
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelect(collectionView: UICollectionView, itemAt indexPath: IndexPath)
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout
}
