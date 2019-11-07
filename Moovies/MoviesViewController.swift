//
//  ViewController.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var viewModel: MoviesControllerViewModel

    init(viewModel: MoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var moviesCollectionView: UICollectionView {
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

