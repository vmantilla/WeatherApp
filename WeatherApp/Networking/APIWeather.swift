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
    
    // MARK: - API Key Conversion
    /* During Development The API key is stored in a PLIST file named "Secrets", which is added to the git ignore to prevent it from being pushed to the repository. However, during production deployment, the API key is provided as a DATA object and converted to a string.
     Example:
     let apiKeyData = Data([234, 1, 54, 23, 23, 166, .... , 67, 6, 65, 97, 12, 101, 56, 6, 7])
     let apiKeyString = apiKeyData.map { String(format: "%02hhx", $0) }.joined()
    */
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
            return .get
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

