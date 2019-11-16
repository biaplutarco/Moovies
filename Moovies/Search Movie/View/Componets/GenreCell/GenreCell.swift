//
//  GenreCell.swift
//  Moovies
//
//  Created by aluno on 07/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    var viewModel: GenreCellViewModel! {
        didSet {
            genreButton.setTitle(viewModel.name, for: .normal)
            setupView()
        }
    }
    
    lazy var genreButton: UIButton = {
        let button = UIButton()
        button.setTitle("loading", for: .normal)
        button.backgroundColor = .action
        button.layer.cornerRadius = 20
        return button
    }()
}

extension GenreCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(genreButton)
    }
    
    func setupConstraints() {
        genreButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            genreButton.topAnchor.constraint(equalTo: topAnchor),
            genreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
