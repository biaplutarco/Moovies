//
//  ViewController.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

enum ControllerViewModelingType {
    case genre
    case movie
}

import UIKit

class CollectionViewController: UIViewController {
    
    var viewModelType: ControllerViewModelingType
    
    lazy var viewModel: ControllerViewModeling = {
        switch viewModelType {
        case .genre:
            return GenresControllerViewModel(collectionViewCell: GenreCell.self)
        case .movie:
            return MoviesControllerViewModel(collectionViewCell: MovieCell.self)
        }
    }()
            
    init(viewModelOfType type: ControllerViewModelingType) {
        self.viewModelType = type
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
        collectionView.backgroundColor = .clear
        resgisterCellTo(collectionView: collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func resgisterCellTo(collectionView: UICollectionView) {
        switch viewModelType {
        case .genre:
            collectionView.registerCell(of: GenreCell.self)
        case .movie:
            collectionView.registerCell(of: MovieCell.self)
        }
    }
    
    private func setupNavigationBar() {
        self.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension CollectionViewController: ViewCoding {
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
        view.backgroundColor = .black
        setupNavigationBar()
        
        viewModel.needReload = {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch viewModelType {
        case .genre:
            let cell = collectionView.dequeueCell(of: GenreCell.self, forIndexPath: indexPath)
            cell.viewModel = viewModel.getCellViewModelTo(indexPath: indexPath) as? GenreCellViewModel

            return cell
            
        case .movie:
            let cell = collectionView.dequeueCell(of: MovieCell.self, forIndexPath: indexPath)
            cell.viewModel = viewModel.getCellViewModelTo(indexPath: indexPath) as? MovieCellViewModel
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getSizeOfItemsTo(collectionView: collectionView)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
}
