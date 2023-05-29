//
//  ServerError.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation

struct ServerError: Codable {
    let error: DetailedError
}

struct DetailedError: Codable {
    let code: Int
    let message: String
}

enum NetworkServiceError: Error, Equatable {
    case serverError(code: Int, message: String)
    case decodingError
    case unknownError
}
