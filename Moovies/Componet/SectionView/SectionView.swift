//
//  SectionView.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class SectionView: UIView {
    var viewModel: SectionViewModeling {
        didSet {
            viewModel.reloadData = {
                DispatchQueue.main.async {
                    self.collectionViewModel.data = self.viewModel.data
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var collectionViewModel: CollectionViewModeling
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.makeFor(viewModel: collectionViewModel)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(viewModel: SectionViewModeling, collectionViewModel: CollectionViewModeling) {
        self.viewModel = viewModel
        self.collectionViewModel = collectionViewModel
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -12),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        
        viewModel.reloadData = {
            DispatchQueue.main.async {
                self.collectionViewModel.data = self.viewModel.data
                self.collectionView.reloadData()
            }
        }
    }
}

extension SectionView: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionViewModel.dequeueCellTo(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewModel.didSelect(collectionView: collectionView, itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionViewModel.itemSize
    }
}
