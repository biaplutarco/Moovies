//
//  CoreDataModel.swift
//  Moovies
//
//  Created by aluno on 08/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataModel: ModelType {
    associatedtype Context = NSManagedObjectContext
}

extension CoreDataModel where Self: NSManagedObject {
    static var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        do {
            try Self.context.save()
        } catch {
            print(error)
        }
    }
    
    func destroy() {
        Self.context.delete(self)
        do {
            try Self.context.save()
        } catch {
            print(error)
        }
    }
    
    static func destroy(_ movie: Movie) {
        let predicate = NSPredicate(format: "title == %@", movie.title)
        let favoritedMovie = FavoriteMovie.find(predicate: predicate)
        favoritedMovie.forEach { $0.destroy() }
    }
    
    static func all() -> [Self] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Self.className)
        fetchRequest.predicate = NSPredicate(value: true)
        
        do {
            return try context.fetch(fetchRequest) as! [Self]
        } catch {
            print(error)
            return []
        }
    }
    
    static func find(predicate: NSPredicate) -> [Self] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Self.className)
        fetchRequest.predicate = predicate
        
        do {
            return try context.fetch(fetchRequest) as! [Self]
        } catch {
            print(error)
            return []
        }
    }
}
