//
//  EventsTests.swift
//  EventsTests
//
//  Created by Christian Leon on 26/03/24.
//

import XCTest
@testable import Events

class EventListViewControllerTests: XCTestCase {
    
    var viewController: EventListViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController
        viewController.loadViewIfNeeded()
    }

    func testViewInitialization() {
        XCTAssertNotNil(viewController.eventsTableView)
        XCTAssertNotNil(viewController.eventsSearchBar)
        XCTAssertNotNil(viewController.noInternetLabel)
        XCTAssertTrue(viewController.eventsTableView.isHidden)
        XCTAssertTrue(viewController.eventsSearchBar.isHidden)
        XCTAssertTrue(viewController.noInternetLabel.isHidden)
    }

    func testTableViewDataSource() {
        XCTAssertNotNil(viewController.eventsTableView.dataSource)
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }

    func testSearchBarDelegate() {
        XCTAssertNotNil(viewController.eventsSearchBar.delegate)
        XCTAssertTrue(viewController.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.searchBar(_:textDidChange:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.searchBarCancelButtonClicked(_:))))
    }
}
