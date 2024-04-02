//
//  ViewController.swift
//  Events
//
//  Created by Christian Leon on 26/03/24.
//

import UIKit
import SDWebImage

class EventListViewController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var eventsSearchBar: UISearchBar!
    @IBOutlet weak var noInternetLabel: UILabel!

    let viewModel = EventListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupTableView()
        setupSearchBar()
        setUpErrorElements()
        bindViewModel()
        
    }
    
    private func setupTableView() {
        eventsTableView.register(EventTableViewCell.nib(), forCellReuseIdentifier: EventTableViewCell.identifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.isHidden = true
    }
    
    private func setupSearchBar() {
        eventsSearchBar.delegate = self
        eventsSearchBar.isHidden = true
    }
    
    private func setUpErrorElements() {
        noInternetLabel.isHidden = true
    }
    
    private func bindViewModel() {
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.eventsTableView.isHidden = false
                self?.eventsSearchBar.isHidden = false
                self?.noInternetLabel.isHidden = true
                self?.eventsTableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.eventsTableView.isHidden = true
                self?.eventsSearchBar.isHidden = true
                self?.noInternetLabel.text = error
                self?.noInternetLabel.isHidden = false
            }
        }
        
        viewModel.onErrorSearchBar = { [weak self] error in
            DispatchQueue.main.async {
                self?.eventsTableView.isHidden = true
                self?.eventsSearchBar.isHidden = false
                self?.noInternetLabel.text = error
                self?.noInternetLabel.isHidden = false
            }
        }
        
        viewModel.onErrorNoData = { [weak self] error in
            DispatchQueue.main.async {
                self?.eventsTableView.isHidden = true
                self?.eventsSearchBar.isHidden = true
                self?.noInternetLabel.text = error
                self?.noInternetLabel.isHidden = false
            }
        }
        
        viewModel.fetchEvents()
    }
}
