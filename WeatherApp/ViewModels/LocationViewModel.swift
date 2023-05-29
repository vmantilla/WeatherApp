//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import Foundation

protocol LocationViewModelProtocol: AnyObject {
    var delegate: LocationViewModelDelegate? { get set }
    func searchLocation(query: String)
    func clearLocations()
    func getLocationCount() -> Int
    func getLocation(at index: Int) -> Location?
}

protocol LocationViewModelDelegate: AnyObject {
    func locationViewModelDidUpdateLocations()
    func locationViewModelDidFailWithError(error: Error)
}

class LocationViewModel: LocationViewModelProtocol {
    
    weak var delegate: LocationViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    
    private var locations: [Location] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func searchLocation(query: String) {
        
        self.clearLocations()
        
        networkService.getLocations(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let location):
                self.locations = location
                self.delegate?.locationViewModelDidUpdateLocations()
            case .failure(let error):
                self.delegate?.locationViewModelDidFailWithError(error: error)
            }
        }
    }
    
    func getLocationCount() -> Int {
        return locations.count
    }
    
    func getLocation(at index: Int) -> Location? {
        return locations.safe(at: index)
    }
    
    func clearLocations() {
        locations.removeAll()
        self.delegate?.locationViewModelDidUpdateLocations()
    }
}
