//
//  SectionViewModeling.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

protocol SectionViewModeling: CollectionViewModeling {
    var title: String { get set }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout
}

extension SectionViewModeling {
    func createCollectionView() -> UICollectionView {
        let flowLayout = createCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        registerCellTo(collectionView: collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }
}
