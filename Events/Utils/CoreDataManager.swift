//
//  CoreDataManager.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
        
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Events")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    // Obtener el contexto de Core Data (Thread-Safe)
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Guardar cambios en el contexto (Thread-Safe)
    func saveContext(completionHandler: @escaping () -> Void) {
        let context = managedObjectContext()
        if context.hasChanges {
            do {
                try context.save()
                completionHandler()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.localizedDescription)")
            }
        }
    }
    
    // Fetch de eventos desde Core Data (Thread-Safe)
    func fetchEventsFromCoreData() -> [EventEntity]? {
        let context = managedObjectContext()
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()

        do {
            let events = try context.fetch(fetchRequest)
            return events
        } catch {
            print("Error fetching events from Core Data: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Guardar eventos en Core Data (Thread-Safe)
    func saveEventsToCoreData(_ events: [Event]?, completionHandler: @escaping () -> Void) {
        guard let events = events else { return }
        let context = managedObjectContext()
        
        context.perform {
            for event in events {
                let eventEntity = EventEntity(context: context)
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
            }
            
            self.saveContext(completionHandler: completionHandler)
        }
    }
    
    // Eliminar todos los eventos de Core Data (Thread-Safe)
    func deleteAllEventsFromCoreData(completionHandler: @escaping () -> Void) {
        let context = managedObjectContext()
        let fetchRequest: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        
        context.perform {
            do {
                let events = try context.fetch(fetchRequest)
                for event in events {
                    context.delete(event)
                }
                
                try context.save()
                print("Todos los eventos han sido eliminados exitosamente.")
                completionHandler()
            } catch {
                print("Error al eliminar eventos de CoreData: \(error.localizedDescription)")
                completionHandler()
            }
        }
    }
}
