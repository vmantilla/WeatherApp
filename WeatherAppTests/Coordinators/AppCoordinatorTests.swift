//
//  AppCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class AppCoordinatorTests: XCTestCase {
    var appCoordinator: AppCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        appCoordinator = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testStart() {
        // Given
        XCTAssertEqual(appCoordinator.childCoordinators.count, 0)
        
        // When
        appCoordinator.start()
        
        // Then
        // Verify that a search coordinator has been created and added to the child coordinators
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
        XCTAssertTrue(appCoordinator.childCoordinators.first is LocationCoordinator)
        
        // Verify that the navigation controller has the search coordinator's view controller at the top
        XCTAssertEqual(navigationController.topViewController, appCoordinator.childCoordinators.first?.navigationController.topViewController)
    }
}
