//
//  EventTableViewCellTests.swift
//  EventsTests
//
//  Created by Christian Leon on 1/04/24.
//

import XCTest
@testable import Events

class EventTableViewCellTests: XCTestCase {
    
    var cell: EventTableViewCell!

    override func setUpWithError() throws {
        cell = Bundle.main.loadNibNamed("EventTableViewCell", owner: nil, options: nil)?.first as? EventTableViewCell
    }

    func testCellConfiguration() {
        let event = Event(name: "Test Event", images: [EventImage(url: "test-url")], _embedded: VenueWrapper(venues: [Venue(name: "Test Venue", city: City(name: "Test City"), state: State(name: "Test State", stateCode: "TS"))]))
        cell.configure(with: event)
        XCTAssertEqual(cell.eventNameLabel.text, "Test Event")
        XCTAssertEqual(cell.placeLabel.text, "Test Venue")
        XCTAssertEqual(cell.locationLabel.text, "Test State, TS")
    }
}
