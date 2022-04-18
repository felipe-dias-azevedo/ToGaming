//
//  Persistence.swift
//  ToGaming
//
//  Created by felipe azevedo on 10/04/22.
//

import CoreData
import SwiftUI

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        _ = PreviewData.Games(to: viewContext)
        _ = PreviewData.GamesSearch(to: viewContext)
        _ = PreviewData.UsersConfig(to: viewContext)
        
        result.save(context: viewContext)
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToGaming")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func getUserConfig() -> UserConfigCore? {
        do {
            let fetchRequest: NSFetchRequest<UserConfigCore> = UserConfigCore.fetchRequest()
            fetchRequest.fetchLimit = 1
            let results = try container.viewContext.fetch(fetchRequest)
            
            return results.first
        } catch {
            return nil
        }
    }
}

extension GameCore {
    static var example: GameCore {
        let context = PersistenceController.preview.container.viewContext
                
        let fetchRequest: NSFetchRequest<GameCore> = GameCore.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
    
    static var examples: [FetchedResults<GameCore>.Element] {
        let context = PersistenceController.preview.container.viewContext
                
        let fetchRequest: NSFetchRequest<GameCore> = GameCore.fetchRequest()
        
        let results = try? context.fetch(fetchRequest)
        
        return results!
    }
}

extension GameSearchCore {
    static var example: GameSearchCore {
        let context = PersistenceController.preview.container.viewContext
                
        let fetchRequest: NSFetchRequest<GameSearchCore> = GameSearchCore.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
    
    static var examples: [FetchedResults<GameSearchCore>.Element] {
        let context = PersistenceController.preview.container.viewContext
                
        let fetchRequest: NSFetchRequest<GameSearchCore> = GameSearchCore.fetchRequest()
        
        let results = try? context.fetch(fetchRequest)
        
        return results!
    }
}
