import Foundation
import CoreData

class EventListViewModel: NetworkStatusObserver {
    
    var events: [Event] = []
    var filteredEvents: [Event] = []
    var hasLoadedEvents: Bool = false
    
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var onErrorSearchBar: ((String) -> Void)?
    var onErrorNoData: ((String) -> Void)?
    var onButtonPressed: (() -> Void)?
    
    private let networkManager: NetworkManagerProtocol
    private var managedObjectContext: NSManagedObjectContext
    private var coreDataManager: CoreDataManager
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext(), coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.managedObjectContext = managedObjectContext
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
        self.networkManager.addObserver(self)
    }
    
    deinit {
        self.networkManager.removeObserver(self)
    }
    
    func filterEvents(by searchText: String) {
        if searchText.isEmpty {
            filteredEvents = events
        } else {
            filteredEvents = events.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
            if filteredEvents.count == 0 {
                self.onErrorSearchBar?("There is no match for what you're looking for")
                return
            }
        }
        onDataUpdate?()
    }
    
    func networkStatusDidChange(_ isConnected: Bool) {
        if isConnected == true && !hasLoadedEvents {
            fetchEvents()
        } else if !isConnected && !hasLoadedEvents {
            fetchFromCoreData()
        }
    }
    
    func event(at index: Int) -> Event? {
        guard index >= 0 && index < filteredEvents.count else { return nil }
        return filteredEvents[index]
    }
    
    func numberOfEvents() -> Int {
        return filteredEvents.count
    }
    
    func fetchEvents() {
        if networkManager.isConnected {
            networkManager.fetchEvents { [weak self] events in
                let group = DispatchGroup()
                group.enter()
                self?.coreDataManager.deleteAllEventsFromCoreData {
                    group.leave()
                }
                group.enter()
                self?.coreDataManager.saveEventsToCoreData(events) {
                    group.leave()
                }
                self?.events = events ?? []
                self?.filteredEvents = events ?? []
                self?.onDataUpdate?()
            } completionError: { error in
                self.onError?("There was a problem fetching the events")
            }
        } else {
            let events = coreDataManager.fetchEventsFromCoreData() ?? []
            let eventsModel = fromCoreDataToModel(events: events)
            self.events = eventsModel
            self.filteredEvents = eventsModel
            if self.events.count == 0 {
                self.onErrorNoData?("Looks like you haven't connected to the internet yet")
            } else {
                self.onDataUpdate?()
            }
        }
    }
    
    func fetchFromCoreData() {
        let events = coreDataManager.fetchEventsFromCoreData() ?? []
        let eventsModel = fromCoreDataToModel(events: events)
        self.events = eventsModel
        self.filteredEvents = eventsModel
        if self.events.isEmpty {
            hasLoadedEvents = false
            self.onErrorNoData?("Looks like you don't have internet connection")
        } else {
            hasLoadedEvents = true
            self.onDataUpdate?()
        }
    }
    
    func fromCoreDataToModel(events: [EventEntity]) -> [Event] {
        var eventArray: [Event] = []
        for event in events {
            let item = Event(name: event.name, images: [EventImage(url: event.image)], _embedded: VenueWrapper(venues: [Venue(name: event.place, city: City(name: ""), state: State(name: event.location, stateCode: nil))]))
            eventArray.append(item)
        }
        return eventArray
    }
    
    private func handleEventFetchSuccess(_ events: [Event]) {
        self.events = events
        self.filteredEvents = events
        self.onDataUpdate?()
    }

    private func handleEventFetchFailure(_ errorMessage: String) {
        self.onError?(errorMessage)
    }
}
