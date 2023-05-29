//
//  NetworkServiceTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import XCTest
@testable import WeatherApp

class NetworkServiceTests: XCTestCase {
    
    class MockNetworkService: NetworkServiceProtocol {
        var getLocationCalled = false
        var getForecastCalled = false
        
        func getLocation(query: String, completion: @escaping (Result<Location, NetworkServiceError>) -> Void) {
            getLocationCalled = true
            
            // Simulate success response
            let location = Location(name: "London", country: "UK")
            completion(.success(location))
        }
        
        func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void) {
            getForecastCalled = true
            
            // Simulate failure response
            completion(.failure(.requestFailed(error: "Failed to get forecast")))
        }
    }
    
    func testGetLocation() {
        let mockService = MockNetworkService()
        
        mockService.getLocation(query: "London") { result in
            switch result {
            case .success(let location):
                XCTAssertEqual(location.name, "London")
                XCTAssertEqual(location.country, "UK")
            case .failure:
                XCTFail("Should not fail")
            }
        }
        
        XCTAssertTrue(mockService.getLocationCalled)
    }
    
    func testGetForecast() {
        let mockService = MockNetworkService()
        
        mockService.getForecast(query: "London", days: 5) { result in
            switch result {
            case .success:
                XCTFail("Should fail")
            case .failure(let error):
                XCTAssertEqual(error, .requestFailed(error: "Failed to get forecast"))
            }
        }
        
        XCTAssertTrue(mockService.getForecastCalled)
    }
}
