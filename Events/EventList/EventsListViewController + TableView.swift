//
//  EventsListViewController + TableView.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import UIKit

// MARK: - UITableViewDataSource

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        cell.invalidateIntrinsicContentSize()
        if let event = viewModel.event(at: indexPath.row) {
            cell.configure(with: event)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
