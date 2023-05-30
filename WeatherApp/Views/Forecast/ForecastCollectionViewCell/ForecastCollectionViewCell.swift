//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import UIKit
import Kingfisher

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    @IBOutlet private var conditionText: UILabel!
    
    static let reuseIdentifier = String(describing: ForecastCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }
    
    private func configureStyle() {
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        layer.cornerRadius = 10
    }
    
    func configure(with forecast: DayForecast) {
        dayLabel.text = String.convertToDayOfWeek(from: forecast.date)?.uppercased() ?? ""
        conditionText.text = forecast.day.condition.text
        configureTemperatureLabels(with: forecast.day)
        configureWeatherIcon(with: forecast.day.condition.icon)
    }
    
    private func configureTemperatureLabels(with dayForecast: DayDetails) {
        let maxTempText = String(format: NSLocalizedString("max_temperature", comment: "") + " %.0f°C", dayForecast.maxTempCelsius)
        let minTempText = String(format: NSLocalizedString("min_temperature", comment: "") + " %.0f°C", dayForecast.minTempCelsius)
        
        maxTempLabel.text = maxTempText
        minTempLabel.text = minTempText
    }
    
    private func configureWeatherIcon(with iconURLString: String) {
        let fullURLString = "https:" + iconURLString
        guard let url = URL(string: fullURLString) else { return }
        weatherIconImageView.kf.setImage(with: url)
    }
}
