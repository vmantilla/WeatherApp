//  ForecastViewModel.swift
//  WeatherApp
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation

protocol ForecastViewModelProtocol: AnyObject {
    var delegate: ForecastViewModelDelegate? { get set }
    func fetchForecast(for days: Int)
    func getForecast() -> Forecast?
    func getCurrentWeather() -> CurrentWeather?
    func getCurrentLocation() -> Location
    func getImageNameForWeatherCondition() -> String
}

protocol ForecastViewModelDelegate: AnyObject {
    func forecastViewModelDidUpdateForecast()
    func forecastViewModelDidFailWithError(error: Error)
}

class ForecastViewModel: ForecastViewModelProtocol {
    
    weak var delegate: ForecastViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    private var location: Location
    
    private var forecast: Forecast?
    
    init(location: Location, networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.location = location
        self.networkService = networkService
    }
    
    func fetchForecast(for days: Int) {
        networkService.getForecast(query: "\(location.name) \(location.country)", days: days) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let forecast):
                self.forecast = forecast
                self.delegate?.forecastViewModelDidUpdateForecast()
            case .failure(let error):
                self.delegate?.forecastViewModelDidFailWithError(error: error)
            }
        }
    }
    
    func getForecast() -> Forecast? {
        return forecast
    }
    
    func getForecast(at index: Int) -> DayForecast? {
        return forecast?.forecast.forecastday.safe(at: index) as? DayForecast
    }
    
    func getCurrentWeather() -> CurrentWeather? {
        return forecast?.current
    }
    
    func getCurrentLocation() -> Location {
        return location
    }

    func getImageNameForWeatherCondition() -> String {
        if let weatherConditionCode = forecast?.current.condition.code {
            switch weatherConditionCode {
            case 1000:
                return "sunny"
            case 1003, 1006, 1009:
                return "cloudy"
            case 1066, 1114, 1117, 1210, 1213, 1216, 1219, 1222, 1225, 1279, 1282:
                return "snow"
            case 1063, 1150, 1153, 1180, 1183, 1186, 1189, 1192, 1195, 1240, 1243, 1246, 1273, 1276:
                return "rain"
            default:
                return "night"
            }
        }
        return "sunny"
    }
}
