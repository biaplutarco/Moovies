//
//  FavoriteView.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    var viewModel: FavoriteViewModel
    weak var delegate: CollectionViewControllerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(),
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        viewModel.registerCellTo(collectionView: collectionView)
        return collectionView
    }()
       
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.setTitleColor(UIColor.action, for: .normal)
        return button
    }()
    

    init(viewModel: FavoriteViewModel, delegate: CollectionViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(collectionView)
        addSubview(searchButton)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            searchButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 48),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 12)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

extension FavoriteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.dequeueCellTo(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(collectionView: collectionView, itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.getItemSizeTo(collectionView: collectionView)
    }
}
