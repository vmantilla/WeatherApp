//
//  APIWeather.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation
import Alamofire

struct Secrets {
    static let shared: [String: Any] = {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("Unable to find Secrets.plist")
        }
        return dict
    }()
}

enum APIWeather: URLRequestConvertible {
    
    static var baseURL: String {
        guard let baseURL = Secrets.shared["baseURL"] as? String else {
            fatalError("Unable to find baseURL in Secrets.plist")
        }
        return baseURL
    }
    
    static var apiKey: String {
        guard let apiKey = Secrets.shared["apiKey"] as? String else {
            fatalError("Unable to find apiKey in Secrets.plist")
        }
        return apiKey
    }
    
    case search(query: String)
    case forecast(query: String, days: Int)
    
    var path: String {
        switch self {
        case .search:
            return "/v1/search.json"
        case .forecast:
            return "/v1/forecast.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .forecast:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query):
            return ["key": APIWeather.apiKey, "q": query]
        case .forecast(let query, let days):
            return ["key": APIWeather.apiKey, "q": query, "days": days]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIWeather.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.method = method
        request.timeoutInterval = TimeInterval(10*1000)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

