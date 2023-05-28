//
//  SearchViewControllerTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import XCTest
@testable import WeatherApp

class SearchViewControllerTests: XCTestCase {
    var searchViewController: SearchViewController!
    
    override func setUp() {
        super.setUp()
        searchViewController = SearchViewController()
    }
    
    override func tearDown() {
        searchViewController = nil
        super.tearDown()
    }
    
    func testSearchViewControllerExists() {
        XCTAssertNotNil(SearchViewController.self)
    }
}
