//
//  LocationViewModelTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import XCTest
@testable import WeatherApp

class LocationViewModelTests: XCTestCase {
    
    class MockNetworkService: NetworkServiceProtocol {
        var getLocationCalled = false
        
        func getLocations(query: String, completion: @escaping (Result<[Location], NetworkServiceError>) -> Void) {
            getLocationCalled = true
            
            if query == "London" {
                // Simulate success response
                let location = Location(id: 1, name: "London", country: "UK")
                completion(.success([location]))
            } else {
                // Simulate failure response
                completion(.failure(.requestFailed(error: "Failed to get location")))
            }
        }
        
        func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void) {
            // Not implemented for this test
        }
    }
    
    var viewModel: LocationViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        viewModel = LocationViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        
        super.tearDown()
    }
    
    func testSearchLocationSuccess() {
        let query = "London"
        let expectation = XCTestExpectation(description: "Search Location Success")
        
        viewModel.delegate = self
        viewModel.searchLocation(query: query)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockNetworkService.getLocationCalled)
            XCTAssertEqual(self.viewModel.getLocationCount(), 1)
            XCTAssertEqual(self.viewModel.getLocation(at: 0)?.name, "London")
            XCTAssertEqual(self.viewModel.getLocation(at: 0)?.country, "UK")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testSearchLocationFailure() {
        let query = "Paris"
        let expectation = XCTestExpectation(description: "Search Location Failure")
        
        viewModel.delegate = self
        viewModel.searchLocation(query: query)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockNetworkService.getLocationCalled)
            XCTAssertEqual(self.viewModel.getLocationCount(), 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
}

extension LocationViewModelTests: LocationViewModelDelegate {
    func locationViewModelDidUpdateLocations() {
        // Not used for this test
    }
    
    func locationViewModelDidFailWithError(error: Error) {
        // Not used for this test
    }
}

