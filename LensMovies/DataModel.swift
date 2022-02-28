//
//  DataModelManager.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import CoreData

typealias PersistenceContainer = DataModel

class DataModel: ObservableObject {
    
    static let shared = DataModel()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                debugPrint("Data Saved")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DataModel {
    @nonobjc class func fetchRequest<Entity: NSManagedObject>() -> NSFetchRequest<Entity> {
        let name = "\(Entity.self)"
        debugPrint("Running fetch request \(name)")
        let request = NSFetchRequest<Entity>(entityName: name)
        request.sortDescriptors = []
        return request
    }
    
    func deleteItem(_ id: String) {
        let fetchRequest: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        if let objects = try? context.fetch(fetchRequest) {
            for obj in objects {
                context.delete(obj)
            }
        }

        do {
            try context.save()
        } catch {
            // Do something... fatalerror
        }
    }
    
    func checkIfItemExist(_ id: String) -> Bool {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            let count = try context.count(for: request)
            return count > 0
        }catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            return false
        }
    }
    
    func saveToFavorite(_ model: MovieModel?) {
        guard let item = model else { return }
        
        let local = WatchList(context: context)
        local.id = item.id.description
        local.name = item.title

        saveContext()
    }
}
