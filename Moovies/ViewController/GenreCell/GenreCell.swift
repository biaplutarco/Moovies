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
            genreLabel.text = viewModel.name
            setupView()
        }
    }
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "loading"
        return label
    }()

}

extension GenreCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(genreLabel)
    }
    
    func setupConstraints() {
        genreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
