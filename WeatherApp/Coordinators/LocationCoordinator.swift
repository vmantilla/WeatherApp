//
//  LocationCoordinator.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class LocationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LocationViewModel()
        let locationViewController = LocationViewController(viewModel: viewModel)
        locationViewController.coordinator = self
        navigationController.pushViewController(locationViewController, animated: true)
    }
    
    func showLocationDetails(location: Location) {
        let forecastCoordinator = ForecastCoordinator(navigationController: navigationController, location: location)
        forecastCoordinator.parentCoordinator = self
        childCoordinators.append(forecastCoordinator)
        forecastCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
