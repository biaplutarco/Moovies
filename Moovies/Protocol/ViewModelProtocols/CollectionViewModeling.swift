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

extension CollectionViewModeling {
    func createCollectionView() -> UICollectionView {
        let flowLayout = createCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        registerCellTo(collectionView: collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }
}
