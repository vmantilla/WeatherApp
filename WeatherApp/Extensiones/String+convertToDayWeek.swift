//
//  String+convertToDayWeek.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import Foundation

extension String {
    static func convertToDayOfWeek(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = "EEE dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

