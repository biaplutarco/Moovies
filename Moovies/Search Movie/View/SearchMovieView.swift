//
//  SearchMovieView.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class SearchMovieView: UIView {
    var viewModel: MovieViewModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Buscar Filmes"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    lazy var genresView: GenresView = {
        let genresViewModel = GenresViewModel(delegate: self)
        let genresView = GenresView(viewModel: genresViewModel)
        return genresView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchMovieView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(genresView)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        genresView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            genresView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            genresView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            genresView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            genresView.heightAnchor.constraint(equalToConstant: 80),

            collectionView.topAnchor.constraint(equalTo: genresView.bottomAnchor, constant: 48),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

extension SearchMovieView: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel?.dequeueCellTo(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelect(collectionView: collectionView, itemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.getItemSizeTo(collectionView: collectionView) ?? CGSize()
    }
}

extension SearchMovieView: GenresViewDelegate {
    func didSelectedGenre(_ genre: Genre) {
        viewModel = MovieViewModel(genre: genre)
        
        viewModel!.getData()
        viewModel!.registerCellTo(collectionView: collectionView)

        viewModel!.reloadData = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
