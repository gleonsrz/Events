//
//  NetworkManager.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import Foundation
import Network

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var observers: [NetworkStatusObserver] = []
    
    private(set) var isConnected: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    // Start monitoring network status
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.notifyObserversNetworkStatusChange()
        }
        monitor.start(queue: queue)
    }
    
    // Add observer for network status changes
    func addObserver(_ observer: NetworkStatusObserver) {
        observers.append(observer)
        observer.networkStatusDidChange(isConnected)
    }
    
    // Remove observer for network status changes
    func removeObserver(_ observer: NetworkStatusObserver) {
        observers = observers.filter { $0 !== observer }
    }
    
    // Notify observers about network status change
    private func notifyObserversNetworkStatusChange() {
        observers.forEach { $0.networkStatusDidChange(isConnected) }
    }
    
    // Stop monitoring network status
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func fetchEvents(completionHandler: @escaping ([Event]?) -> Void, completionError: @escaping (String) -> Void) {
        guard let url = URL(string: Constants.eventsUrlWithApiKey) else {
            completionError("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error with fetching events: \(error)")
                completionError(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionError("Unexpected status code")
                return
            }
            
            guard let data = data else {
                completionError("No data received")
                return
            }
            
            do {
                let eventsEmbedding = try JSONDecoder().decode(EventsEmbedding.self, from: data)
                let events = eventsEmbedding._embedded?.events ?? []
                completionHandler(events)
            } catch {
                print("Error decoding data: \(error)")
                completionError("Error decoding data")
            }
        }
        task.resume()
    }
}

protocol NetworkStatusObserver: AnyObject {
    func networkStatusDidChange(_ isConnected: Bool)
}
