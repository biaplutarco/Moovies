//
//  SearchMovieView.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class SearchMovieView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Buscar Filmes"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    lazy var genreSectionView: SectionView = {
        let genresViewModel = GenresViewModel(delegate: self)
        let sectionView = SectionView(viewModel: genresViewModel)
        return sectionView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createMovieSectionWith(viewModel: MoviesViewModel) {
        let movieSectionView = SectionView(viewModel: viewModel)
        addSubview(movieSectionView)
        
        movieSectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieSectionView.topAnchor.constraint(equalTo: genreSectionView.bottomAnchor, constant: 48),
            movieSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            movieSectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            movieSectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48)
        ])
    }
}

extension SearchMovieView: ViewCoding {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(genreSectionView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        genreSectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            genreSectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            genreSectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            genreSectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            genreSectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

extension SearchMovieView: SectionViewDelegate {
    func didSelectedGenre(_ genre: Genre) {
        let moviesViewModel = MoviesViewModel(genre: genre)
        createMovieSectionWith(viewModel: moviesViewModel)
    }
}
