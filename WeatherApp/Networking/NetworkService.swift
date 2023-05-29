//
//  NetworkService.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func getLocation(query: String, completion: @escaping (Result<Location, NetworkServiceError>) -> Void)
    func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void)
}

enum NetworkServiceError: Error, Equatable {
    case requestFailed(error: String)
    case decodingError
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    func performRequest<T: Decodable>(endpoint: APIWeather, responseType: T.Type, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        do {
            let request = try endpoint.asURLRequest()
            
            AF.request(request).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.requestFailed(error: error.localizedDescription)))
                }
            }
        } catch {
            completion(.failure(.decodingError))
        }
    }
    
    func getLocation(query: String, completion: @escaping (Result<Location, NetworkServiceError>) -> Void) {
        performRequest(endpoint: .search(query: query), responseType: Location.self, completion: completion)
    }
    
    func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void) {
        performRequest(endpoint: .forecast(query: query, days: days), responseType: Forecast.self, completion: completion)
    }
}


