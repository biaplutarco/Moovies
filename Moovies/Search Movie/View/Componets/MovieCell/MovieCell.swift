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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 12
        view.layer.opacity = 0.5
        return view
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
        label.textColor = .white
        label.textAlignment = .center
        label.text = "loading"
        label.numberOfLines = 3
        return label
    }()
}

extension MovieCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(posterImageView)
        addSubview(blackView)
        addSubview(favoriteButton)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        blackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
