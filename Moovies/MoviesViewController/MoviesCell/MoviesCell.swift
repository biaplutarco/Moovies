//
//  MoviesCollectionViewCell.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    
    var viewModel: MoviesCellViewModel! {
        didSet {
            releaseDateLabel.text = viewModel.realeseDate
            posterImageView.getImageFrom(path: viewModel.posterPath)
        }
    }
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.getImageFrom(path: nil)
        return imageView
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "loading"
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesCell: ViewCodable {
    func buildViewHierarchy() {
        addSubview(releaseDateLabel)
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            releaseDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 8),
            
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.6),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .green
        layer.cornerRadius = 10
    }
}
