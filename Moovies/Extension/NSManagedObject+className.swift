//
//  NSManagedObject+className.swift
//  Moovies
//
//  Created by aluno on 08/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    static var className: String {
        return String(describing: self)
    }
}
