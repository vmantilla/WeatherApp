//
//  SearchCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class SearchCoordinatorTests: XCTestCase {
    var searchCoordinator: SearchCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        searchCoordinator = SearchCoordinator(navigationController: navigationController)
        // Set up any necessary dependencies for the tests
    }
    
    override func tearDown() {
        searchCoordinator = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testStart() {
        // Given
        let expectedViewControllerCount = navigationController.viewControllers.count + 1
        
        // When
        searchCoordinator.start()
        
        // Then
        // Verify that the search coordinator pushed the search view controller onto the navigation stack
        XCTAssertEqual(navigationController.viewControllers.count, expectedViewControllerCount)
        XCTAssertTrue(navigationController.topViewController is SearchViewController)
    }
}
