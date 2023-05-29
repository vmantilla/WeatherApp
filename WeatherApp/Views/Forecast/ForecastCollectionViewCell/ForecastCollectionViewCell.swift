//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import UIKit
import Kingfisher

class ForecastCollectionViewCell: UICollectionViewCell {
    
    private let separatorLine = UIView()
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    @IBOutlet private var conditionText: UILabel!
    
    static let reuseIdentifier = "ForecastCollectionViewCell"
    
    func configureStyle() {
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        layer.cornerRadius = 10
    }
    
    func configure(with forecast: DayForecast) {
        if let formattedDate = String.convertToDayOfWeek(from: forecast.date) {
            dayLabel.text = formattedDate.uppercased()
        } else {
            dayLabel.text = ""
        }
        
        conditionText.text = forecast.day.condition.text
        let conditionIconUrl = "https:\(forecast.day.condition.icon)"
        
        weatherIconImageView.kf.setImage(with: URL(string: conditionIconUrl))
        
        minTempLabel.text = "Max \(forecast.day.minTempCelsius)°C"
        maxTempLabel.text = "Min  \(forecast.day.maxTempCelsius)°C"
        
        configureStyle()
    }
}
