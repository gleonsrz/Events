//
//  MockNetworkManager.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import Foundation
import Network

class MockNetworkManager: NetworkManagerProtocol {
    
    var isConnected: Bool = true // Simula conexión en pruebas
    
    func fetchEvents(completionHandler: @escaping ([Event]?) -> Void, completionError: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var events: [Event]
            let event1 = Event(name: "Event 1", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 1", city: nil, state: nil)]))
            let event2 = Event(name: "Event 2", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 2", city: nil, state: nil)]))
            events = [event1, event2]
            completionHandler(events)
        }
    }
    
    func addObserver(_ observer: NetworkStatusObserver) {
        //
    }
    
    func removeObserver(_ observer: NetworkStatusObserver) {
        //
    }
}

