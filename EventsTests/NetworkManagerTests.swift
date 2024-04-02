//
//  NetworkManagerTests.swift
//  EventsTests
//
//  Created by Christian Leon on 1/04/24.
//

import XCTest
@testable import Events

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManagerProtocol!

    override func setUpWithError() throws {
        networkManager = MockNetworkManager()
    }

    func testFetchEvents() {
        let expectation = XCTestExpectation(description: "Fetch events")
        
        networkManager.fetchEvents { events in
            XCTAssertNotNil(events)
            expectation.fulfill()
        } completionError: { error in
            XCTFail("Failed to fetch events: \(error)")
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
}
