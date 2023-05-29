//
//  APIWeatherTests.swift
//  WeatherAppTests
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import XCTest
@testable import WeatherApp

class APIWeatherTests: XCTestCase {
    
    func testSearchEndpoint() {
        let query = "London"
        let endpoint = APIWeather.search(query: query)
        
        XCTAssertEqual(endpoint.path, "/v1/search.json")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.parameters["q"] as? String, query)
    }
    
    func testForecastEndpoint() {
        let query = "London"
        let days = 5
        let endpoint = APIWeather.forecast(query: query, days: days)
        
        XCTAssertEqual(endpoint.path, "/v1/forecast.json")
        XCTAssertEqual(endpoint.method, .post)
        XCTAssertEqual(endpoint.parameters["q"] as? String, query)
        XCTAssertEqual(endpoint.parameters["days"] as? Int, days)
    }
}
