//
//  NetworkManagerProtocol.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import Foundation

protocol NetworkManagerProtocol {
    var isConnected: Bool { get }
    func addObserver(_ observer: NetworkStatusObserver)
    func removeObserver(_ observer: NetworkStatusObserver)
    func fetchEvents(completionHandler: @escaping ([Event]?) -> Void, completionError: @escaping (String) -> Void)
}
