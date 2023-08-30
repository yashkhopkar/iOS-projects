//
//  CoreDataManager.swift
//  Assignment2
//
//  Created by Yash Khopkar on 2023-06-23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Assignment2")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var toDoFRC: NSFetchedResultsController<ToDo> = {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]
        let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "complete", cacheName: nil)
        return fetchController
    }()
    
    
    func createToDo(task: String, complete: Bool, urgent: Bool) {
            let managedObjectContext = persistentContainer.viewContext
            let newToDo = ToDo(context: managedObjectContext)
            
            newToDo.complete = complete
            newToDo.date = Date()
            newToDo.id = UUID()
            newToDo.task = task
            newToDo.urgent = urgent
            
            saveContext()
        }
        
        func updateToDo(_ toDo: ToDo, task: String, complete: Bool, urgent: Bool) {
            toDo.task = task
            toDo.date = Date()
            toDo.urgent = urgent
            toDo.complete = complete
            
            saveContext()
        }
        
        func deleteToDo(_ toDo: ToDo) {
            let managedObjectContext = persistentContainer.viewContext
            managedObjectContext.delete(toDo)
            
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
