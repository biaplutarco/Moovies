//
//  CollectionViewModeling.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

protocol CollectionViewModeling {
    var title: String { get set }
    var coordinator: AplicationCoordinator { get set }
    var numberOfItems: Int { get set }
    var data: [Any] { get set }
    var reloadData: (() -> Void)? { get set }
    
    func getData()
    func registerCellTo(collectionView: UICollectionView)
    func dequeueCellTo(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getItemSizeTo(collectionView: UICollectionView) -> CGSize 
    func didSelectItemAt(indexPath: IndexPath)
}
