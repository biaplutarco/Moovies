//
//  CollectionViewController.swift
//  Moovies
//
//  Created by aluno on 12/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

//  UICollectionViewController é legal evitar na maioria das vezes, devido a dificuldades na hora de realizar manutenção ou adicionar funcionalidades. Mas como é um teste, e eu não vou fazer manutenção do codigo no futuro, eu achei que seria legal usar ela!

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var viewModel: CollectionViewModeling
    var delegate: CollectionViewControllerDelegate?
    
    init(viewModel: CollectionViewModeling, delegate: CollectionViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupNavigationBar()
//        title = viewModel.title
        collectionView.backgroundColor = .white
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
        let button = UIBarButtonItem(title: "Favorito", style: .plain, target: self ,action: #selector(favoriteTapped))
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
        viewModel.didSelect(collectionView: collectionView, itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getItemSizeTo(collectionView: collectionView)
    }
}


