//
//  ViewCodable.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol ViewCodable {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
