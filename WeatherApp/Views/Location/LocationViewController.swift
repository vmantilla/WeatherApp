//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var coordinator: LocationCoordinator?
    var viewModel: LocationViewModelProtocol!
    
    init(viewModel: LocationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setupSearchController()
    }

    private func setupView() {
        self.view.backgroundColor = .darkGray
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Set the title
        self.title = NSLocalizedString("weather_app", comment: "")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func setupCollectionView() {
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.reuseIdentifier)
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_locations", comment: "")
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = .white
        customizeSearchBar()
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func customizeSearchBar() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = .white
            }
            let glassIconView = textField.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .white
        }
    }

    @objc func searchLocation() {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text, !text.isEmpty else {
            viewModel.clearLocations()
            return
        }
        viewModel.searchLocation(query: text)
    }
}

extension LocationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getLocationCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let location = viewModel.getLocation(at: indexPath.row) {
            cell.configure(with: location)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let location = viewModel.getLocation(at: indexPath.row) {
            // Show location details screen with the selected location
            coordinator?.showLocationDetails(location: location)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20 // Subtracting the spacing between cells (10 on each side)
        let height: CGFloat = 80
        return CGSize(width: width, height: height)
    }
}

extension LocationViewController: LocationViewModelDelegate {
    func locationViewModelDidUpdateLocations() {
        // Handle the update in locations data and update the UI accordingly
        collectionView.reloadData()
    }
    
    func locationViewModelDidFailWithError(title: String, error: String) {
        self.showAlertWithRetryCancel(
            title: title,
            message: error,
            retryHandler: { [weak self] in
                guard let self = self else { return }
                self.searchLocation()
            },
            cancelHandler: { }
        )
    }
}

extension LocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchLocation()
    }
}
