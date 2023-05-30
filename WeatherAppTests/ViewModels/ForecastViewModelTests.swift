//
//  ForecastViewModelTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 30/05/23.
//

import XCTest
@testable import WeatherApp

class ForecastViewModelTests: XCTestCase {
    
    class MockNetworkService: NetworkServiceProtocol {
        var getForecastCalled = false
        
        func getLocations(query: String, completion: @escaping (Result<[Location], NetworkServiceError>) -> Void) {
            // Not implemented for this test
        }
        
        func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void) {
            getForecastCalled = true
            
            if query == "London UK" {
                // Simulate success response
                let location = Location(id: 1, name: "London", country: "UK")
                let currentWeather = CurrentWeather(lastUpdatedEpoch: 0, lastUpdated: "", tempCelsius: 0, tempFahrenheit: 0, isDay: 0, condition: Condition(text: "", icon: "", code: 0), windMPH: 0, windKPH: 0, windDegree: 0, windDirection: "", pressureMB: 0, pressureIN: 0, precipMM: 0, precipIN: 0, humidity: 0, cloud: 0, feelsLikeCelsius: 0, feelsLikeFahrenheit: 0, visibilityKM: 0, visibilityMiles: 0, uvIndex: 0, gustMPH: 0, gustKPH: 0)
                let forecastDetails = ForecastDetails(forecastday: [])
                let forecast = Forecast(location: location, current: currentWeather, forecast: forecastDetails)
                completion(.success(forecast))
            } else {
                // Simulate failure response
                completion(.failure(.serverError(code: 0, message: "Failed to get forecast")))
            }
        }
    }
    
    var viewModel: ForecastViewModel!
    var mockNetworkService: MockNetworkService!
    var location: Location!
    
    override func setUp() {
        super.setUp()
        
        location = Location(id: 1, name: "London", country: "UK")
        mockNetworkService = MockNetworkService()
        viewModel = ForecastViewModel(location: location, networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        location = nil
        
        super.tearDown()
    }
    
    func testFetchForecastSuccess() {
        let days = 5
        let expectation = XCTestExpectation(description: "Fetch Forecast Success")
        
        viewModel.fetchForecast(for: days)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockNetworkService.getForecastCalled)
            XCTAssertNotNil(self.viewModel.getForecast())
            XCTAssertNotNil(self.viewModel.getCurrentWeather())
            XCTAssertEqual(self.viewModel.getCurrentLocation().name, self.location.name)
            XCTAssertEqual(self.viewModel.getCurrentLocation().country, self.location.country)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testFetchForecastFailure() {
        let days = 5
        let expectation = XCTestExpectation(description: "Fetch Forecast Success")
        
        location = Location(id: 1, name: "London Fail", country: "UK")
        viewModel = ForecastViewModel(location: location, networkService: mockNetworkService)
        viewModel.fetchForecast(for: days)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockNetworkService.getForecastCalled)
            XCTAssertNil(self.viewModel.getForecast())
            XCTAssertNil(self.viewModel.getCurrentWeather())
            XCTAssertEqual(self.viewModel.getCurrentLocation().name, self.location.name)
            XCTAssertEqual(self.viewModel.getCurrentLocation().country, self.location.country)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
    }
}
