//
//  CurrentCollectionViewCell.swift
//  WeatherApp
//

import UIKit

class CurrentCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var currentTemperatureLabel: UILabel!
    @IBOutlet private var conditionTextLabel: UILabel!
    @IBOutlet private var minTemperatureLabel: UILabel!
    @IBOutlet private var maxTemperatureLabel: UILabel!
    
    static let reuseIdentifier = String(describing: CurrentCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
    }
    
    func configure(with currentWeather: CurrentWeather, location: Location) {
        configureCityLabel(with: location)
        configureTemperatureLabel(with: currentWeather)
        configureConditionTextLabel(with: currentWeather)
        configureMinTemperatureLabel(with: currentWeather)
        configureMaxTemperatureLabel(with: currentWeather)
    }
    
    private func configureCityLabel(with location: Location) {
        cityLabel.text = location.name
    }
    
    private func configureTemperatureLabel(with currentWeather: CurrentWeather) {
        let temperatureText = String(format: "%.0f°C", currentWeather.tempCelsius)
        currentTemperatureLabel.text = temperatureText
    }
    
    private func configureConditionTextLabel(with currentWeather: CurrentWeather) {
        conditionTextLabel.text = currentWeather.condition.text
    }
    
    private func configureMinTemperatureLabel(with currentWeather: CurrentWeather) {
        let humidityText = String(format: NSLocalizedString("humidity", comment: ""), currentWeather.humidity)
        minTemperatureLabel.text = humidityText
    }
    
    private func configureMaxTemperatureLabel(with currentWeather: CurrentWeather) {
        let precipitationText = String(format: NSLocalizedString("precipitation", comment: ""), currentWeather.precipIN)
        maxTemperatureLabel.text = precipitationText
    }
}
