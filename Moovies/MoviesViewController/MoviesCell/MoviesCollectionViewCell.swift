//
//  MoviesCollectionViewCell.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    var viewModel: MoviesCellViewModel! {
        didSet {
            releaseDateLabel.text = viewModel.realeseDate
            posterImageView.getImageFrom(path: viewModel.posterPath)
        }
    }
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.getImageFrom(path: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "loading"
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
