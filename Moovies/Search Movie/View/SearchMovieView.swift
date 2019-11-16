//
//  SearchMovieView.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class SearchMovieView: UIView {
    var viewModel: SearchMovieViewModel
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    lazy var genreSectionView: SectionView = {
        let genresViewModel = GenresViewModel(delegate: self)
        let sectionView = SectionView(viewModel: genresViewModel)
        return sectionView
    }()
    
    lazy var movieSectionView: SectionView = {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""))
        let sectionView = SectionView(viewModel: moviesViewModel)
        return sectionView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.backgroundColor = .action
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTappedSaveButton), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTappedSaveButton() {
        viewModel.saveFavorites()
        viewModel.delegate?.didTappedSaveButton()
    }
}

extension SearchMovieView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(genreSectionView)
        addSubview(movieSectionView)
        addSubview(saveButton)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        genreSectionView.translatesAutoresizingMaskIntoConstraints = false
        movieSectionView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            genreSectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            genreSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            genreSectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            genreSectionView.heightAnchor.constraint(equalToConstant: 90),
            
            movieSectionView.topAnchor.constraint(equalTo: genreSectionView.bottomAnchor, constant: 24),
            movieSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            movieSectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            movieSectionView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -48),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

extension SearchMovieView: SectionViewDelegate {
    func isMovieAlreadyFavorite(_ movie: Movie) -> Bool {
        viewModel.isMovieAlreadyFavorite(movie)
    }
    
    func unFavorite(movie: Movie) {
        viewModel.unFavorite(movie: movie)
    }
    
    func favorite(movie: Movie) {
        viewModel.favorite(movie: movie)
    }
    
    func didSelectedGenre(_ genre: Genre) {
        let moviesViewModel = MoviesViewModel(genre: genre, delegate: self)
        movieSectionView.viewModel = moviesViewModel
    }
}
