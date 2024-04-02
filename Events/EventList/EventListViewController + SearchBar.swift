//
//  EventListViewController + SearchBar.swift
//  Events
//
//  Created by Christian Leon on 1/04/24.
//

import UIKit

// MARK: - UISearchBarDelegate

extension EventListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEvents(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterEvents(by: "")
        searchBar.resignFirstResponder()
    }
}
