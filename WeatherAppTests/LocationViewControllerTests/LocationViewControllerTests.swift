//
//  LocationViewControllerTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class LocationViewControllerTests: XCTestCase {
    
    class MockLocationViewModel: LocationViewModelProtocol {
        var delegate: LocationViewModelDelegate?
        var locationCount = 0
        var locationToReturn: Location?
        var queryToSearch: String?
        
        func getLocationCount() -> Int {
            return locationCount
        }
        
        func getLocation(at index: Int) -> Location? {
            return locationToReturn
        }
        
        func searchLocation(query: String) {
            queryToSearch = query
        }
        
        func clearLocations() {
            locationCount = 0
        }
    }
    
    var locationViewController: LocationViewController!
    var viewModel: MockLocationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MockLocationViewModel()
        locationViewController = LocationViewController(viewModel: viewModel)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        locationViewController.collectionView = collectionView
        
        locationViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        locationViewController = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchViewControllerExists() {
        XCTAssertNotNil(LocationViewController.self)
    }
    
    func testNumberOfItemsInSection() {
        viewModel.locationCount = 5
        let numberOfItems = locationViewController.collectionView(locationViewController.collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, 5)
    }
    
    func testCellForItemAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.locationToReturn = Location(id: 1, name: "Test Location", country: "Test Country")
        let cell = locationViewController.collectionView(locationViewController.collectionView, cellForItemAt: indexPath)
        XCTAssertTrue(cell is LocationCollectionViewCell)
    }
    
    func testDidSelectItemAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.locationToReturn = Location(id: 1, name: "Test Location", country: "Test Country")
        locationViewController.collectionView(locationViewController.collectionView, didSelectItemAt: indexPath)
        XCTAssertEqual(viewModel.locationToReturn?.name, "Test Location")
    }
    
    func testSearchLocation() {
        locationViewController.searchController.searchBar.text = "Test Search"
        locationViewController.searchLocation()
        XCTAssertEqual(viewModel.queryToSearch, "Test Search")
    }
}
