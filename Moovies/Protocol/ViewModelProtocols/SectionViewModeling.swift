//
//  SectionViewModeling.swift
//  Moovies
//
//  Created by aluno on 15/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

protocol SectionViewModeling {
    var title: String { get set }
    var data: [Any] { get set }
    var reloadData: (() -> Void)? { get set }
    func getData()
}

