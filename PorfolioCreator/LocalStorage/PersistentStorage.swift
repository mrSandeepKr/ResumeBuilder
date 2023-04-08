//
//  Context.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 07/04/23.
//

import CoreData

class PersistentStorage {
    private init() {}
    
    static let shared = PersistentStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "dataModel")
        container.loadPersistentStores { storeDesc, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchRequest<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try context.fetch(managedObject.fetchRequest()) as? [T]
            else {
                return nil
            }
            return result
        }
        catch {
            debugPrint("fetching data failed for \(String.init(describing: T.self)) with \(error)")
            return nil
        }
    }
}
