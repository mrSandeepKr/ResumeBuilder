//
//  Context.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 07/04/23.
//

import CoreData

class PersistentStorage {
    private init() {
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextObjectsDidChange,
                                               object: nil, queue: nil, using: contextObjectsDidChange)
    }
    
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
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject> ?? []
        let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject> ?? []
        let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject> ?? []
        
        var updatedEntitiesSet = Set<String>()
        updatedObjects.union(insertedObjects).union(deletedObjects).forEach({updatedEntitiesSet.insert($0.entity.name ?? "")})
        
        for entityName in updatedEntitiesSet {
            switch entityName {
                case "CDExperience":
                    NotificationCenter.default.post(name: .UpdateExperience, object: nil)
                case "CDEducation":
                    NotificationCenter.default.post(name: .UpdateEducation, object: nil)
                case "CDSkill":
                    NotificationCenter.default.post(name: .UpdateSkill, object: nil)
                case "CDAbout":
                    NotificationCenter.default.post(name: .UpdateAbout, object: nil)
                default:
                    break
            }
        }
    }
}
