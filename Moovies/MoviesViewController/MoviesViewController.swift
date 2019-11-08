//
//  ViewController.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var viewModel: MoviesControllerViewModel

    init(viewModel: MoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(of: MoviesCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension MoviesViewController: ViewCoding {
    func buildViewHierarchy() {
        view.addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .orange
        
        viewModel.needReload = {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: MoviesCell.self, forIndexPath: indexPath)
        cell.viewModel = viewModel.getMovieCellViewModelTo(indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
}
