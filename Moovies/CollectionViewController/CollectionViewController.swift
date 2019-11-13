//
//  CollectionViewController.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var viewModel: CollectionViewModeling
    var delegate: CollectionViewControllerDelegate?
    
    init(viewModel: CollectionViewModeling) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupNavigationBar()
        title = viewModel.title
        viewModel.registerCellTo(collectionView: collectionView)

        viewModel.getData()
        viewModel.reloadData = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.tintColor = .action
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        let button = UIBarButtonItem(title: "Favorite", style: .plain, target: self ,action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func favoriteTapped() {
        delegate?.didTappedFavorites()
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.dequeueCellTo(collectionView: collectionView, indexPath: indexPath)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getItemSizeTo(collectionView: collectionView)
    }
}


