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
            titleLabel.text = viewModel.name
            setupView()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                genreBackgroundView.backgroundColor = .selected
            } else {
                genreBackgroundView.backgroundColor = .action
            }
        }
    }
    
    lazy var genreBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .action
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}

extension GenreCell: ViewCoding {
    func buildViewHierarchy() {
        addSubview(genreBackgroundView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        genreBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            genreBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            genreBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            genreBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            genreBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
