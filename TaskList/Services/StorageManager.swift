//
//  StorageManager.swift
//  TaskList
//
//  Created by ikorobov on 22.08.2022.
//

import Foundation
import CoreData


class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = StorageManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func deleteContext(with object: NSManagedObject) {
        let context = StorageManager.shared.persistentContainer.viewContext
        context.delete(object)
        saveContext()
    }
    
}

