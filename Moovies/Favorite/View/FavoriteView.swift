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
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.registerCell(of: MovieCell.self)
        return collectionView
    }()
       
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.setTitleColor(UIColor.selected, for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var emptyLabel: UILabel = {
       let label = UILabel()
        label.text = viewModel.isEmptyMessage
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getEmptyFeedback() {
        emptyLabel.isHidden = !viewModel.isEmpty
    }
    
    @objc func didTappedButton(_ sender: UIButton) {
        viewModel.delegate?.didTappedSearchButton()
    }
    
    func reloadData() {
        getEmptyFeedback()
        viewModel.updateScreen()
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
    }
}

extension FavoriteView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(collectionView)
        addSubview(searchButton)
        addSubview(emptyLabel)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -12),
            
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        
        getEmptyFeedback()
        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
    }
}

extension FavoriteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: MovieCell.self, forIndexPath: indexPath)
        guard let viewModel = viewModel.getMovieCellViewModel(of: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.removeFromFavorites(at: indexPath.row)
    }
}
