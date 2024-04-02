//
//  CoreDataManagerTests.swift
//  EventsTests
//
//  Created by Christian Leon on 1/04/24.
//

import XCTest
import CoreData
@testable import Events

class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = MockCoreDataManager.shared
    }
    
    override func tearDown() {
        coreDataManager.deleteAllEventsFromCoreData {}
        coreDataManager = nil
        super.tearDown()
    }
    
    func testSaveAndFetchEvents() {
        let event1 = Event(name: "Event 1", images: [EventImage(url: "image_url_1")], _embedded: VenueWrapper(venues: [Venue(name: "Venue 1", city: City(name: ""), state: State(name: "Location 1", stateCode: ""))]))
        
        let event2 = Event(name: "Event 2", images: [EventImage(url: "image_url_2")], _embedded: VenueWrapper(venues: [Venue(name: "Venue 2", city: City(name: ""), state: State(name: "Location 2", stateCode: ""))]))
        
        coreDataManager.saveEventsToCoreData([event1, event2]) {}
        
        let savedEvents = coreDataManager.fetchEventsFromCoreData()
        
        XCTAssertEqual(savedEvents?.count, 2)
    }
    
    func testDeleteAllEvents() {
        let event1 = Event(name: "Event 1", images: [EventImage(url: "image_url_1")], _embedded: VenueWrapper(venues: [Venue(name: "Venue 1", city: City(name: ""), state: State(name: "Location 1", stateCode: ""))]))
        
        let event2 = Event(name: "Event 2", images: [EventImage(url: "image_url_2")], _embedded: VenueWrapper(venues: [Venue(name: "Venue 2", city: City(name: ""), state: State(name: "Location 2", stateCode: ""))]))
        
        coreDataManager.saveEventsToCoreData([event1, event2]) {}
        
        coreDataManager.deleteAllEventsFromCoreData {}
        
        let savedEvents = coreDataManager.fetchEventsFromCoreData()
        XCTAssertEqual(savedEvents?.count, 0)
    }
}
