//
//  ViewCoding.swift
//  Moovies
//
//  Created by aluno on 13/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol ViewCoding {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCoding {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
