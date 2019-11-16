//
//  SearchMovieViewController.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {
    var viewModel: SearchMovieViewModel
    
    lazy var searchMovieView: SearchMovieView = {
        let searchMovieView = SearchMovieView(viewModel: viewModel)
        return searchMovieView
    }()
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension SearchMovieViewController: ViewCoding {
    func buildViewHierarchy() {
        view.addSubview(searchMovieView)
    }
    
    func setupConstraints() {
        searchMovieView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchMovieView.topAnchor.constraint(equalTo: view.topAnchor),
            searchMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .background
    }
}
