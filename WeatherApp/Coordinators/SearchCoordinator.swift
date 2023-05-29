//
//  SearchCoordinator.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let searchVC = SearchViewController()
        searchVC.coordinator = self
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func showLocationDetails(location: Location) {
        
    }
}
