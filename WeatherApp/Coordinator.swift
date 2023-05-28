//
//  Coordinator.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
