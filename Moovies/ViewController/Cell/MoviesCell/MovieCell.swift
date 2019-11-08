//
//  MoviesCollectionViewCell.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var viewModel: MovieCellViewModel! {
        didSet {
            releaseDateLabel.text = viewModel.title
            posterImageView.getImageFrom(path: viewModel.posterPath)
            setupView()
        }
    }
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.getImageFrom(path: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "loading"
        return label
    }()

}

extension MovieCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(releaseDateLabel)
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            releaseDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 8),
            
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.6),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .orange
    }
}
