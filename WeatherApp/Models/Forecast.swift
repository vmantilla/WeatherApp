//
//  Forecast.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation

struct Forecast: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: ForecastDetails
    
    private enum CodingKeys: String, CodingKey {
        case location, current, forecast
    }
}

struct CurrentWeather: Codable {
    let lastUpdatedEpoch: TimeInterval
    let lastUpdated: String
    let tempCelsius: Double
    let tempFahrenheit: Double
    let isDay: Int
    let condition: Condition
    let windMPH: Double
    let windKPH: Double
    let windDegree: Int
    let windDirection: String
    let pressureMB: Double
    let pressureIN: Double
    let precipMM: Double
    let precipIN: Double
    let humidity: Int
    let cloud: Int
    let feelsLikeCelsius: Double
    let feelsLikeFahrenheit: Double
    let visibilityKM: Double
    let visibilityMiles: Double
    let uvIndex: Double
    let gustMPH: Double
    let gustKPH: Double
    
    private enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case isDay = "is_day"
        case condition
        case windMPH = "wind_mph"
        case windKPH = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIN = "pressure_in"
        case precipMM = "precip_mm"
        case precipIN = "precip_in"
        case humidity
        case cloud
        case feelsLikeCelsius = "feelslike_c"
        case feelsLikeFahrenheit = "feelslike_f"
        case visibilityKM = "vis_km"
        case visibilityMiles = "vis_miles"
        case uvIndex = "uv"
        case gustMPH = "gust_mph"
        case gustKPH = "gust_kph"
    }
}

struct ForecastDetails: Codable {
    let forecastday: [DayForecast]
    
    private enum CodingKeys: String, CodingKey {
        case forecastday
    }
}

struct DayForecast: Codable {
    let date: String
    let dateEpoch: TimeInterval
    let day: DayDetails
    
    private enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
    }
}

struct DayDetails: Codable {
    let maxTempCelsius: Double
    let maxTempFahrenheit: Double
    let minTempCelsius: Double
    let minTempFahrenheit: Double
    let avgTempCelsius: Double
    let avgTempFahrenheit: Double
    let maxWindMPH: Double
    let maxWindKPH: Double
    let totalPrecipMM: Double
    let totalPrecipIN: Double
    let totalSnowCM: Double
    let avgVisibilityKM: Double
    let avgVisibilityMiles: Double
    let avgHumidity: Double
    let willItRain: Int
    let chanceOfRain: Int
    let willItSnow: Int
    let chanceOfSnow: Int
    let condition: Condition
    let uvIndex: Double
    
    private enum CodingKeys: String, CodingKey {
        case maxTempCelsius = "maxtemp_c"
        case maxTempFahrenheit = "maxtemp_f"
        case minTempCelsius = "mintemp_c"
        case minTempFahrenheit = "mintemp_f"
        case avgTempCelsius = "avgtemp_c"
        case avgTempFahrenheit = "avgtemp_f"
        case maxWindMPH = "maxwind_mph"
        case maxWindKPH = "maxwind_kph"
        case totalPrecipMM = "totalprecip_mm"
        case totalPrecipIN = "totalprecip_in"
        case totalSnowCM = "totalsnow_cm"
        case avgVisibilityKM = "avgvis_km"
        case avgVisibilityMiles = "avgvis_miles"
        case avgHumidity = "avghumidity"
        case willItRain = "daily_will_it_rain"
        case chanceOfRain = "daily_chance_of_rain"
        case willItSnow = "daily_will_it_snow"
        case chanceOfSnow = "daily_chance_of_snow"
        case condition
        case uvIndex = "uv"
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
