//
//  ActiveRecordType.swift
//  Moovies
//
//  Created by aluno on 08/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

protocol Writeable {
    func save()
}

protocol Readable {
    static func all() -> [Self]
    static func find(predicate: NSPredicate) -> [Self]
}

protocol Deletable {
    func destroy()
}

protocol ActiveRecordType: Writeable, Deletable, Readable {
    
}

protocol ModelType: ActiveRecordType {
    associatedtype Context
    static var context: Self.Context { get }
}
