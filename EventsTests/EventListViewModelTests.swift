//
//  EventListViewModelTests.swift
//  EventsTests
//
//  Created by Christian Leon on 1/04/24.
//

import XCTest
@testable import Events

class EventListViewModelTests: XCTestCase {
    
    var viewModel: EventListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = EventListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFilterEventsWithMatch() {
        let event1 = Event(name: "Event 1", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 1", city: nil, state: nil)]))
        let event2 = Event(name: "Event 2", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 2", city: nil, state: nil)]))
        viewModel.events = [event1, event2]
        
        viewModel.filterEvents(by: "Event 1")
        
        XCTAssertEqual(viewModel.numberOfEvents(), 1)
        XCTAssertEqual(viewModel.event(at: 0)?.name, "Event 1")
    }
    
    func testFilterEventsWithoutMatch() {
        let event1 = Event(name: "Event 1", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 1", city: nil, state: nil)]))
        let event2 = Event(name: "Event 2", images: nil, _embedded: VenueWrapper(venues: [Venue(name: "Venue 2", city: nil, state: nil)]))
        viewModel.events = [event1, event2]
        
        viewModel.filterEvents(by: "Event 3")
        
        XCTAssertEqual(viewModel.numberOfEvents(), 0)
    }
}
