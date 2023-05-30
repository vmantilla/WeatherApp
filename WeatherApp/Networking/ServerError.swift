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
    
    func handle() -> (title: String, message: String) {
        var title: String
        var message: String

        switch self {
        case .serverError(let code, let errorMessage):
            title = NSLocalizedString("server_error", comment: "")
            message = NSLocalizedString("server_error_message", comment: "") + " \(code): \(errorMessage)"
        case .decodingError:
            title = NSLocalizedString("decoding_error", comment: "")
            message = NSLocalizedString("decoding_error_message", comment: "")
        case .unknownError:
            title = NSLocalizedString("unknown_error", comment: "")
            message = NSLocalizedString("unknown_error_message", comment: "")
        }
        return (title, message)
    }
}
