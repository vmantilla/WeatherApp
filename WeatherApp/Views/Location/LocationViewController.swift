//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var coordinator: LocationCoordinator?
    var viewModel: LocationViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the view model
        viewModel = LocationViewModel()
        viewModel.delegate = self
        
        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseIdentifier)
        
        // Set up UISearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Locations"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Set up pull-to-refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(searchLocation), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func searchLocation() {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text, !text.isEmpty else {
            viewModel.clearLocations()
            return
        }
        viewModel.searchLocation(query: text)
    }
}

extension LocationViewController: LocationViewModelDelegate {
    func locationViewModelDidUpdateLocations() {
        // Handle the update in locations data and update the UI accordingly
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func locationViewModelDidFailWithError(error: Error) {
        // Handle the error and display an appropriate message to the user
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.searchLocation()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        refreshControl.endRefreshing()
    }
}

extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getLocationCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        
        if let location = viewModel.getLocation(at: indexPath.row) {
            cell.configure(with: location)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = viewModel.getLocation(at: indexPath.row) {
            // Show location details screen with the selected location
            coordinator?.showLocationDetails(location: location)
        }
    }
}

extension LocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchLocation()
    }
}
