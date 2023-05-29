//
//  LocationViewControllerTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class LocationViewControllerTests: XCTestCase {
    var locationViewController: LocationViewController!
    
    override func setUp() {
        super.setUp()
        locationViewController = LocationViewController()
    }
    
    override func tearDown() {
        locationViewController = nil
        super.tearDown()
    }
    
    func testSearchViewControllerExists() {
        XCTAssertNotNil(LocationViewController.self)
    }
}
