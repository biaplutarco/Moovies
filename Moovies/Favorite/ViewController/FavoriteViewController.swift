//
//  FavoriteViewController.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var viewModel: FavoriteViewModel
    
    lazy var favoriteView: FavoriteView = {
        let favoriteView = FavoriteView(viewModel: viewModel)
        return favoriteView
    }()
    
    init(viewModel: FavoriteViewModel, title: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        favoriteView.reloadData()
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
    }
}
