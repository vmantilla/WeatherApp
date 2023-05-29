//
//  CurrentCollectionViewCell.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import UIKit

class CurrentCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CurrentCollectionViewCell"

    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var currentTemperatureLabel: UILabel!
    @IBOutlet private var conditionTextLabel: UILabel!
    @IBOutlet private var minTemperatureLabel: UILabel!
    @IBOutlet private var maxTemperatureLabel: UILabel!
    
    func configure(with currentWeather: CurrentWeather, location: Location) {
        contentView.backgroundColor = .clear
        cityLabel.text = location.name
        currentTemperatureLabel.text = String(format: "%.0f°C", currentWeather.tempCelsius)
        conditionTextLabel.text = currentWeather.condition.text
        minTemperatureLabel.text = "Humedad: \(currentWeather.humidity)%"
        maxTemperatureLabel.text = "Precipitacion: \(currentWeather.precipIN)°"
    }
}
