//
//  Event.swift
//  Events
//
//  Created by Christian Leon on 27/03/24.
//

import Foundation

struct EventsEmbedding: Codable {
    let _embedded: EventsWrapper?
}

struct EventsWrapper: Codable {
    let events: [Event]?
}

struct Event: Codable {
    let name: String?
    let images: [EventImage]?
    let _embedded: VenueWrapper
}

struct EventImage: Codable {
    let url: String?
}

struct VenueWrapper: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let name: String?
    let city: City?
    let state: State?
}

struct City: Codable {
    let name: String?
}

struct State: Codable {
    let name: String?
    let stateCode: String?
}
