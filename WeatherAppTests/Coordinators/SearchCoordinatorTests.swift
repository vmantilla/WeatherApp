//
//  LocationCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class LocationCoordinatorTests: XCTestCase {
    var locationCoordinator: LocationCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        locationCoordinator = LocationCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        locationCoordinator = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testStart() {
        // Given
        let expectedViewControllerCount = navigationController.viewControllers.count + 1
        
        // When
        locationCoordinator.start()
        
        // Then
        // Verify that the search coordinator pushed the search view controller onto the navigation stack
        XCTAssertEqual(navigationController.viewControllers.count, expectedViewControllerCount)
        XCTAssertTrue(navigationController.topViewController is LocationViewController)
    }
}
