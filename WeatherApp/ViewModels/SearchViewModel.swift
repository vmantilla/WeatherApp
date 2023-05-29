//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    func searchLocation(query: String)
    func getLocationCount() -> Int
    func getLocation(at index: Int) -> Location?
}

protocol SearchViewModelDelegate: AnyObject {
    func searchViewModelDidUpdateLocations()
    func searchViewModelDidFailWithError(error: Error)
}

class SearchViewModel: SearchViewModelProtocol {
    
    weak var delegate: SearchViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    
    private var locations: [Location] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func searchLocation(query: String) {
        networkService.getLocations(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let location):
                self.locations.append(contentsOf: location)
                self.delegate?.searchViewModelDidUpdateLocations()
            case .failure(let error):
                self.delegate?.searchViewModelDidFailWithError(error: error)
            }
        }
    }
    
    func getLocationCount() -> Int {
        return locations.count
    }
    
    func getLocation(at index: Int) -> Location? {
        return locations.safe(at: index)
    }
}
