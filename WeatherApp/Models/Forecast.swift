//
//  Forecast.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation

struct Forecast: Codable {
    let location: Location
    let forecast: [DayForecast]
}

struct DayForecast: Codable {
    let date: String
    let avgtemp: Int
    let condition: String
}
