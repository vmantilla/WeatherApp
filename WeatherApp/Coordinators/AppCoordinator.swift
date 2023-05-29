//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        searchCoordinator.start()
        childCoordinators.append(searchCoordinator)
    }
}
