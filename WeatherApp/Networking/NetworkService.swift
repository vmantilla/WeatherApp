//
//  NetworkService.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func getLocations(query: String, completion: @escaping (Result<[Location], NetworkServiceError>) -> Void)
    func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void)
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
                    // Ocurrió un error durante la decodificación
                    print("Error: \(error)")
                    if let data = response.data {
                        let decoder = JSONDecoder()
                        if let serverError = try? decoder.decode(ServerError.self, from: data) {
                            completion(.failure(.serverError(code: serverError.error.code, message: serverError.error.message)))
                        } else {
                            completion(.failure(.decodingError))
                        }
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            }
        } catch {
            completion(.failure(.decodingError))
        }
    }
    
    
    func getLocations(query: String, completion: @escaping (Result<[Location], NetworkServiceError>) -> Void) {
        performRequest(endpoint: .search(query: query), responseType: [Location].self, completion: completion)
    }
    
    func getForecast(query: String, days: Int, completion: @escaping (Result<Forecast, NetworkServiceError>) -> Void) {
        performRequest(endpoint: .forecast(query: query, days: days), responseType: Forecast.self, completion: completion)
    }
}


