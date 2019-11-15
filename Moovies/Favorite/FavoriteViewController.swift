//
//  FavoriteViewController.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var viewModel: FavoriteControllerViewModel
    weak var delegate: CollectionViewControllerDelegate?
    
    lazy var favoriteView: FavoriteView = {
        let favoriteView = FavoriteView(viewModel: viewModel.favoriteViewModel)
        return favoriteView
    }()
    
    
    init(viewModel: FavoriteControllerViewModel, delegate: CollectionViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .action
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
    }
}

extension FavoriteViewController: ViewCoding {
    func buildViewHierarchy() {
        view.addSubview(favoriteView)
    }
    
    func setupConstraints() {
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .background
        title = viewModel.title
    }
}
