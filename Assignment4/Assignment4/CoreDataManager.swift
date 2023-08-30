//
//  CoreDataManager.swift
//  Assignment4
//
//  Created by Yash Khopkar on 2023-08-12.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavGameModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var favGameFRC: NSFetchedResultsController<FavGame> = {
        let fetchRequest: NSFetchRequest<FavGame> = FavGame.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "name", cacheName: nil)
        return fetchController
    }()
    
    
    func createFavGame(_name: String, _url: URL) {
            let managedObjectContext = persistentContainer.viewContext
            let newFavGame = FavGame(context: managedObjectContext)
            
            newFavGame.name = _name
            newFavGame.urlString = _url
            saveContext()
        }
        
        
        func deleteFavGame(_favGame: FavGame) {
            let managedObjectContext = persistentContainer.viewContext
            managedObjectContext.delete(_favGame)
            
            saveContext()
        }
        
        private func saveContext() {
            let managedObjectContext = persistentContainer.viewContext
            
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    fatalError("Failed to save context: \(error)")
                }
            }
        }
    
}

