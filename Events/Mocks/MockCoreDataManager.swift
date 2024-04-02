//
//  MockCoreDataManager.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import UIKit
import CoreData

class MockCoreDataManager: CoreDataManagerProtocol {
    
    static let shared = MockCoreDataManager()
    
    private var events: [EventEntity] = []
    
    private init() {}
    
    func fetchEventsFromCoreData() -> [EventEntity]? {
        return events
    }
    
    func saveEventsToCoreData(_ events: [Event]?, completionHandler: @escaping () -> Void) {
        guard let events = events else { return }
        
        for event in events {
            let eventEntity = EventEntity(context: managedObjectContext())
            eventEntity.name = event.name
            
            if let image = event.images?.first {
                eventEntity.image = image.url
            }
            
            if let venue = event._embedded.venues.first {
                eventEntity.place = venue.name
            }
            
            if let state = event._embedded.venues.first?.state {
                eventEntity.location = (state.name ?? "") + ", " + (state.stateCode ?? "")
            }
            
            self.events.append(eventEntity)
        }
        
        completionHandler()
    }
    
    func deleteAllEventsFromCoreData(completionHandler: @escaping () -> Void) {
        events.removeAll()
        completionHandler()
    }
    
    private func managedObjectContext() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let model = NSManagedObjectModel.mergedModel(from: nil)
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            fatalError("Error adding persistent store: \(error)")
        }
        
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }
}
