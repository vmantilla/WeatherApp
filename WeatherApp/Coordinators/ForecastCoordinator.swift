//
//  ForecastCoordinator.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 29/05/23.
//

import UIKit

class ForecastCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var location: Location

    init(navigationController: UINavigationController, location: Location) {
        self.navigationController = navigationController
        self.location = location
    }

    func start() {
        let forecastVM = ForecastViewModel(location: location)
        let forecastVC = ForecastViewController(viewModel: forecastVM)
        forecastVC.coordinator = self
        navigationController.pushViewController(forecastVC, animated: true)
        forecastVM.fetchForecast(for: 5)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator) { }
    
}

