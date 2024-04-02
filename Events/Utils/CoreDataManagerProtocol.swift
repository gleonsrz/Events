//
//  CoreDataManagerProtocol.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import Foundation

protocol CoreDataManagerProtocol {
    func fetchEventsFromCoreData() -> [EventEntity]?
    func saveEventsToCoreData(_ events: [Event]?, completionHandler: @escaping () -> Void)
    func deleteAllEventsFromCoreData(completionHandler: @escaping () -> Void)
}
