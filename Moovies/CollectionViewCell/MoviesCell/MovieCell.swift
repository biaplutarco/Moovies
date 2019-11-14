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
            titleLabel.text = viewModel.title
            posterImageView.getImageFrom(path: viewModel.posterPath)
            setupView()
        }
    }
    
    override var isSelected: Bool {
        didSet {
//            viewModel.getStateOf(button: favoriteButton)
        }
    }
        
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.getImageFrom(path: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .action
        button.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "starFill"), for: .selected)
        button.isSelected = viewModel.getStateOf(button: button)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "loading"
        label.numberOfLines = 2
        return label
    }()
}

extension MovieCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(favoriteButton)
        addSubview(titleLabel)
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
