//
//  UICollectionView+Dequeue+Register.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(of type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("CollectionViewCell wasn't registered")
        }
        return cell
    }
    
    func registerCell<T: UICollectionViewCell>(of type: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
}

extension UICollectionView {
//    var viewModel: CollectionViewModeling {
//        get {
//            return self.viewModel
//        }
//        set(newValue) {
//            self.viewModel = newValue
//        }
//    }
    
    static func makeFor(viewModel: CollectionViewModeling) -> UICollectionView {
        let collectionView = viewModel.createCollectionView()
        return collectionView
    }
}
